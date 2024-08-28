import 'app_error.dart';

final class UpsertError extends AppError {
  static const String notSupported = 'Value not supported';
  static const String nullNotSupported = 'Null value not supported';

  UpsertError({String message = 'Upsert error'}) : super(message);
}
