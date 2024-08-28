abstract interface class BaseDTO {
  /// id to used in database
  String get dbID;

  /// this method is used to convert data to json, then save json in db
  Map<String, dynamic> toJson();
}
