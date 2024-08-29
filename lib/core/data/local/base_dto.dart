import 'package:movie_app_clean_architecture/core/domain/types/json_type.dart';

abstract interface class BaseDTO {
  /// id to used in database
  String get dbID;

  /// this method is used to convert data to json, then save json in db
  JsonType toJson();
}
