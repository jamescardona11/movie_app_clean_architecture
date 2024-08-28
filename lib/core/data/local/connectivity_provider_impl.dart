import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:movie_app_clean_architecture/core/domain/repository/connectivity_provider.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityProviderImpl implements ConnectivityProvider {
  final PublishSubject<bool> _connectivitySubject = PublishSubject<bool>();

  ConnectivityProviderImpl() {
    _initStream();
  }

  bool? _isConnected;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  void _initStream() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(_emitWhenChange);
  }

  @override
  Future<bool> get hasConnection {
    return Connectivity().checkConnectivity().then((connectivityResult) {
      return connectivityResult.any((result) {
        return result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result == ConnectivityResult.ethernet;
      });
    });
  }

  @override
  Stream<bool> get watch => _connectivitySubject.stream;

  @override
  bool? get lastState => _isConnected;

  @override
  Future<void> close() async {
    await _connectivitySubscription?.cancel();
    await _connectivitySubject.close();
  }

  Future<void> _emitWhenChange(List<ConnectivityResult> connectivityResult) async {
    if (connectivityResult.isEmpty) return;

    final isConnected = connectivityResult.any((result) {
      return result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result == ConnectivityResult.ethernet;
    });

    // no emit a new state when is the same as the previous
    if (_isConnected == isConnected) return;
    _isConnected = isConnected;

    _connectivitySubject.add(isConnected);
  }
}
