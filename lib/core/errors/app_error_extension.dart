import 'app_error.dart';

extension AppErrorX on AppError {
  bool get isUnexpectedError => this is UnexpectedError;
  bool get isNoPermissionError => this is NoPermissionError;
}
