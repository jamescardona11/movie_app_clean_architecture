import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app_clean_architecture/core/logger/logger.dart';
import 'package:rxdart/rxdart.dart';

/// This class implements the [_BaseMoc] and is used to create a new Moc,
/// that is a basic Bloc Pattern to manage the state of the application
/// the reason to create this is, the app is small and the state is simple
/// so we can use the basic Bloc Pattern to manage the state

abstract class Moc<MState extends Equatable> {
  Moc(this._initialState) {
    _state = _initialState;

    _stateController = PublishSubject<MState>(
      onListen: () {
        // Add initialState to all new listeners
        _stateController.add(_initialState);
      },
    );
  }

  final MState _initialState;
  late MState _state;

  final List<StreamSubscription> _subscriptions = [];
  late final PublishSubject<MState> _stateController;

  /// This method is to change the current state into a new state
  @protected
  void changeState(MState state) {
    if (_stateController.isClosed) {
      AppLogger().d('changeState() called after was closed');
      return;
    }

    _stateController.add(state);
    _state = state;
  }

  /// Return the current state
  MState get state => _state;

  Stream<MState> get stateStream => _stateController.stream;

  bool get isClosed => _stateController.isClosed;

  void safeSubscribe(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }

  @mustCallSuper
  Future<void> close() {
    _stateController.close();
    return Future.wait(_subscriptions.map((e) => e.cancel()));
  }
}
