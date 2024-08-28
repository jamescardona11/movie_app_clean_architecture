import 'package:equatable/equatable.dart';

abstract base class BaseAppError with EquatableMixin {
  final String message;
  final dynamic err;

  const BaseAppError(this.message, [this.err]);

  @override
  String toString() {
    return Error.safeToString('$message; \n $err');
  }

  @override
  List<Object?> get props => [message, err];
}

final class UnexpectedError extends BaseAppError {
  const UnexpectedError() : super('Encountered a Unexpected at an unrecoverable point. Terminating.');
}

final class ValueObjectError extends BaseAppError {
  const ValueObjectError() : super('Encountered a Unexpected Value Object');
}
