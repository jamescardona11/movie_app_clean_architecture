import 'dart:async';

abstract interface class ConnectivityProvider {
  Future<void> close();

  Stream<bool> get watch;

  Future<bool> get hasConnection;

  bool? get lastState;
}
