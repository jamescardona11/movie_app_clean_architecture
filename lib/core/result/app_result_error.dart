part of 'app_result.dart';

@immutable
final class AppResultError<R> extends AppResult<R> {
  final AppError value;

  const AppResultError(this.value);

  @override
  String toString() => 'AppResultError: $value';

  @override
  List<Object?> get props => value.props;
}
