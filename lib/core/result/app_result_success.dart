part of 'app_result.dart';

@immutable
final class AppResultSuccess<R> extends AppResult<R> {
  final R value;

  const AppResultSuccess(this.value);

  @override
  String toString() => 'AppResultSuccess: $value';

  @override
  List<Object?> get props => [value];
}
