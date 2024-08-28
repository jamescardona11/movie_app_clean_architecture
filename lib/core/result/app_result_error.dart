import '../errors/app_error.dart';
import 'app_result.dart';

final class AppResultError<R> extends AppResult<R> {
  final AppError value;

  AppResultError(this.value);

  @override
  String toString() => 'AppResultError: $value';

  @override
  List<Object?> get props => value.props;
}
