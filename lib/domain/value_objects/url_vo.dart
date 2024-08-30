import 'package:movie_app_clean_architecture/config/environment/url_routes.dart';
import 'package:movie_app_clean_architecture/core/domain/base_value_object.dart';
import 'package:movie_app_clean_architecture/core/errors/app_error.dart';
import 'package:movie_app_clean_architecture/core/result/app_result.dart';

/// This value object is responsible for validating the url of the poster.
/// It checks if the url is empty or if it doesn't match the pattern.
///
/// The goal here is to create and show an example of how to use value objects, and how to validate data.
/// We need to evaluate if this kind of Value Object is the right choice, we don't want to use many Value Objects without any reason.
final class UrlVO extends BaseValueObject<String> {
  const UrlVO._(super.value);

  factory UrlVO.def(String value) {
    final url = '${UrlRoutes.posterURL}$value';

    final notMatch = value.isEmpty ? true : RegExp(_urlPattern, caseSensitive: false).firstMatch(url) == null;
    if (notMatch) {
      return const UrlVO._(AppResultError(ValueObjectError()));
    }

    return UrlVO._(AppResultSuccess('${UrlRoutes.posterURL}$value'));
  }

  static const String _urlPattern = r'^(?:http|https):\/\/'
      r'(?:(?:[A-Z0-9][A-Z0-9_-]*)(?:\.[A-Z0-9][A-Z0-9_-]*)+):?(?:\d+)?'
      r'(?:\/[^\s]*)?$';
}
