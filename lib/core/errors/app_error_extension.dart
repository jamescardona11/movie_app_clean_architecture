import 'base_app_error.dart';

extension AppErrorX on BaseAppError {
  bool get isUnexpectedError => this is UnexpectedError;
}
