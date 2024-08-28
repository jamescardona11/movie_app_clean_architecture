import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_clean_architecture/core/result/app_result.dart';

@immutable
abstract base class BaseValueObject<T> with EquatableMixin {
  final AppResult<T> _value;

  const BaseValueObject(AppResult<T> value) : _value = value;

  bool get isValid => _value.isSuccess;

  /// Returns the value if it is valid, otherwise throws an error.
  T getOrElse([T? defaultValue]) => _value.fold((l) {
        if (defaultValue != null) {
          return defaultValue;
        }

        throw l.value;
      }, (r) => r);

  @override
  String toString() => _value.toString();
}
