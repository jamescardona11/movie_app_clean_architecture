import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_architecture/core/domain/types/json_type.dart';

class DbDAO extends Equatable {
  const DbDAO({
    required this.id,
    required this.data,
  });

  final String id;
  final JsonType data;

  DbDAO formatData() {
    return DbDAO(
      id: id,
      data: data,
    );
  }

  @override
  List<Object?> get props => [id, data];
}
