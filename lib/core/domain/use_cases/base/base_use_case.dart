abstract base class CommandData {}

abstract class BaseUseCase<R extends dynamic, I extends CommandData> {
  R call(I data);
}
