part of 'app_result.dart';

@immutable
final class AppSuccess<R> extends AppResult<R> {
  final R value;

  const AppSuccess(this.value);

  @override
  String toString() => 'AppResultSuccess: $value';

  @override
  List<Object?> get props => [value];
}
