import 'package:equatable/equatable.dart';

abstract class BaseAppError with EquatableMixin {
  final String message;
  final dynamic error;
  final StackTrace? stackTrace;

  const BaseAppError(this.message, {this.error, this.stackTrace});

  @override
  String toString() {
    var msg = 'ErrorType [$runtimeType], \n message: $message,';
    if (error is Error) {
      msg += '\n${(error as Error).stackTrace}';
    }
    if (stackTrace != null) {
      msg += '\nSource stack:\n$stackTrace';
    }

    //return Error.safeToString('$message; \n $error');
    return Error.safeToString(msg);
  }

  @override
  List<Object?> get props => [message, error];
}

final class UnexpectedError extends BaseAppError {
  const UnexpectedError() : super('Encountered a Unexpected at an unrecoverable point. Terminating.');
}

final class ValueObjectError extends BaseAppError {
  const ValueObjectError() : super('Encountered a Unexpected Value Object');
}
