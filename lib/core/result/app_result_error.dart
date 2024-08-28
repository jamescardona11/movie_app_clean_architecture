part of 'app_result.dart';

@immutable
final class AppError<R> extends AppResult<R> {
  final BaseAppError error;

  const AppError(this.error);

  @override
  String toString() => 'AppResultError: $error';

  @override
  List<Object?> get props => error.props;
}
