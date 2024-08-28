abstract class AppError {
  final String message;
  final dynamic err;

  AppError(this.message, [this.err]);

  @override
  String toString() {
    return Error.safeToString('$message $err');
  }
}

final class UnexpectedError extends AppError {
  UnexpectedError() : super('Encountered a Unexpected at an unrecoverable point. Terminating.');
}

final class NoPermissionError extends AppError {
  NoPermissionError({String? type}) : super('No ${type ?? ''} permission error.');
}
