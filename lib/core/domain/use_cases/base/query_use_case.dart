import 'base_use_case.dart';

abstract base class QueryUseCase<R, I extends CommandData> extends BaseUseCase<R, I> {}

abstract base class FutureQueryUseCase<R, I extends CommandData> extends BaseUseCase<Future<R>, I> {}

abstract base class StreamQueryUseCase<R, I extends CommandData> extends BaseUseCase<Stream<R>, I> {}
