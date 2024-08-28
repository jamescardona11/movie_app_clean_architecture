part of 'app_result.dart';

@immutable
final class AppResultError<R> extends AppResult<R> {
  final AppError error;

  const AppResultError(this.error);

  @override
  String toString() => 'AppResultError: $error';

  @override
  List<Object?> get props => error.props;
}
