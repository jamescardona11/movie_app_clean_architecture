import 'package:movie_app_clean_architecture/config/environment/url_routes.dart';
import 'package:movie_app_clean_architecture/core/domain/base_value_object.dart';
import 'package:movie_app_clean_architecture/core/errors/app_error.dart';
import 'package:movie_app_clean_architecture/core/result/app_result.dart';

final class PosterUrl extends BaseValueObject<String> {
  const PosterUrl._(super.value);

  factory PosterUrl.def(String value) {
    if (value.isEmpty) {
      return const PosterUrl._(AppResultError(ValueObjectError()));
    }

    return PosterUrl._(AppResultSuccess('${UrlRoutes.posterURL}$value'));
  }
}
