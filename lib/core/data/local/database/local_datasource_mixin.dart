import 'package:movie_app_clean_architecture/core/data/local/database/db_dao.dart';
import 'package:movie_app_clean_architecture/core/domain/types/json_type.dart';
import 'package:sembast/sembast.dart';

mixin LocalDataSourceMixin {
  String get tableName;

  Database get database;

  StoreRef<String, JsonType> get _store => StoreRef<String, JsonType>(tableName);

  Future<void> upsert(DbDAO dao) => _store.record(dao.id).put(
        database,
        dao.data,
        merge: true,
      );

  Future<void> bulkUpsert(List<DbDAO> daos) async {
    final ids = daos.map((item) => item.id);
    final data = daos.map((item) => item.data).toList();

    return database.transaction((transaction) async {
      await _store.records(ids).put(
            transaction,
            data,
            merge: true,
          );
    });
  }

  Future<void> delete(String id) => _store.record(id).delete(database);

  Future<DbDAO?> read(String id) => _store.record(id).get(database).then((record) {
        if (record == null) return null;

        return DbDAO(
          id: id,
          data: record,
        );
      });

  Stream<DbDAO?> watchOne(String id) => _store.record(id).onSnapshot(database).map(
        (snapshot) => snapshot == null
            ? null
            : DbDAO(
                id: id,
                data: snapshot.value,
              ),
      );

  Stream<List<DbDAO>> watch([Finder? finder]) => _store.query(finder: finder).onSnapshots(database).map(
        (snapshots) => snapshots
            .map(
              (e) => DbDAO(
                id: e.key,
                data: e.value,
              ),
            )
            .toList(),
      );

  Future<void> dropTable() => _store.drop(database);
}
