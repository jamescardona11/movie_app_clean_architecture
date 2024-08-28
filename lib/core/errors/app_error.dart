import 'package:equatable/equatable.dart';

abstract base class AppError with EquatableMixin {
  final String message;
  final dynamic err;

  const AppError(this.message, [this.err]);

  @override
  String toString() {
    return Error.safeToString('$message; \n $err');
  }

  @override
  List<Object?> get props => [message, err];
}

final class UnexpectedError extends AppError {
  const UnexpectedError() : super('Encountered a Unexpected at an unrecoverable point. Terminating.');
}

final class ValueObjectError extends AppError {
  const ValueObjectError() : super('Encountered a Unexpected Value Object');
}
