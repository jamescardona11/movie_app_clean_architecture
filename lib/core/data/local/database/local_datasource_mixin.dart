import 'package:movie_app_clean_architecture/core/data/local/database/db_dao.dart';
import 'package:movie_app_clean_architecture/core/domain/types/json_type.dart';
import 'package:sembast/sembast.dart';

mixin LocalDataSourceMixin {
  Database get database;

  StoreRef<String, JsonType> _store(String tableName) => StoreRef<String, JsonType>(tableName);

  Future<void> upsert(String tableName, DbDAO dao) => _store(tableName).record(dao.id).put(
        database,
        dao.data,
        merge: true,
      );

  Future<void> bulkUpsert(String tableName, List<DbDAO> daos) async {
    final ids = daos.map((item) => item.id);
    final data = daos.map((item) => item.data).toList();

    return database.transaction((transaction) async {
      await _store(tableName).records(ids).put(
            transaction,
            data,
            merge: true,
          );
    });
  }

  Future<void> delete(String tableName, String id) => _store(tableName).record(id).delete(database);

  Future<DbDAO?> read(String tableName, String id) => _store(tableName).record(id).get(database).then((record) {
        if (record == null) return null;

        return DbDAO(
          id: id,
          data: record,
        );
      });

  Stream<DbDAO?> watchOne(String tableName, String id) => _store(tableName).record(id).onSnapshot(database).map(
        (snapshot) => snapshot == null
            ? null
            : DbDAO(
                id: id,
                data: snapshot.value,
              ),
      );

  Stream<List<DbDAO>> watch(String tableName, [Finder? finder]) => _store(tableName).query(finder: finder).onSnapshots(database).map(
        (snapshots) => snapshots
            .map(
              (e) => DbDAO(
                id: e.key,
                data: e.value,
              ),
            )
            .toList(),
      );

  Future<void> dropTable(
    String tableName,
  ) =>
      _store(tableName).drop(database);
}
