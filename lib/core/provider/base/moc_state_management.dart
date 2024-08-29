import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:movie_app_clean_architecture/core/logger/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'base_moc_state_management.dart';

/// This class implements the [_BaseMoc] and is used to create a new Moc,
/// that is a basic Bloc Pattern to manage the state of the application
/// the reason to create this is, the app is small and the state is simple
/// so we can use the basic Bloc Pattern to manage the state

abstract class Moc<MState> extends _BaseMoc<MState> {
  Moc(super.initialState);

  final List<StreamSubscription> _subscriptions = [];

  /// This method is used to change the state of the Moc
  /// This method is called when a new event is dispatched with new [MocEvent]
  @override
  Stream<MState> changeStateFromEvent(MocEvent event, MState state) async* {}

  Stream<MState> get stateStream => _stateController.stream;

  void safeSubscribe(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }

  @override
  @mustCallSuper
  Future<void> close() {
    super.close();
    return Future.wait(_subscriptions.map((e) => e.cancel()));
  }
}
