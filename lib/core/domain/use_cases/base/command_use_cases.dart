import 'base_use_case.dart';

abstract base class CommandUseCase<I extends CommandData> implements BaseUseCase<void, I> {}

abstract base class FutureCommandUseCase<I extends CommandData> extends BaseUseCase<Future<void>, I> {}
