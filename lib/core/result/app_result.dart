import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../errors/base_app_error.dart';

part 'app_result_error.dart';
part 'app_result_success.dart';

typedef SuccessCompletion<V, T> = T Function(V value);
typedef ErrorCompletion<V, T> = T Function(V error);

/// This is a custom class, but you can use fpdart or dartz for this.
/// Basically, you can use this class to represent the result of an operation.
/// The main difference between use dartz/fpdart Either/Option is in all cases for this app my left value is AppError.
///
/// It has methods to check if the result is an error or a success.
/// It provides methods to get the error or success value as nullable.
/// The fold method takes two functions as parameters, one for handling errors and one for handling success cases.
/// It calls the appropriate function based on whether the result is an error or a success.

@immutable
abstract class AppResult<R> with EquatableMixin {
  const AppResult();

  bool get isError => this is AppError;
  bool get isSuccess => this is AppSuccess<R>;

  BaseAppError? get toNullableError {
    if (isError) {
      return (this as AppError).error;
    }
    return null;
  }

  R? get toNullableSuccess {
    if (isSuccess) {
      return (this as AppSuccess<R>).value;
    }
    return null;
  }

  /// Returns a new value of [Result] from closure
  T fold<T>(ErrorCompletion<BaseAppError, T> failure, SuccessCompletion<R, T> success) {
    if (isSuccess) {
      final right = this as AppSuccess<R>;
      return success(right.value);
    } else {
      final left = this as AppError;
      return failure(left.error);
    }
  }
}

class Unit {
  const Unit();
}

const unit = Unit();
