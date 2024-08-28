import 'app_result.dart';

final class AppResultSuccess<R> extends AppResult<R> {
  final R value;

  AppResultSuccess(this.value);

  @override
  String toString() => 'AppResultSuccess: $value';

  @override
  List<Object?> get props => [value];
}
