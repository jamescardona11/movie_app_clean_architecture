import 'package:equatable/equatable.dart';

abstract base class AppError with EquatableMixin {
  final String message;
  final dynamic err;

  AppError(this.message, [this.err]);

  @override
  String toString() {
    return Error.safeToString('$message; \n $err');
  }

  @override
  List<Object?> get props => [message, err];
}

final class UnexpectedError extends AppError {
  UnexpectedError() : super('Encountered a Unexpected at an unrecoverable point. Terminating.');
}
