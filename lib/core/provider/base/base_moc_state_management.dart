part of 'moc_state_management.dart';

/// This class is the base class for Moc (State Management)
/// Contains the basic methods and properties for a Moc
/// Define the eventController and stateController transformers
abstract class _BaseMoc<MState extends Equatable> {
  _BaseMoc(this._initialState) {
    _state = _initialState;

    _stateController = PublishSubject<MState>(
      onListen: () {
        // Add initialState to all new listeners
        _stateController.add(_initialState);
      },
    );
    _eventControllerTransformer();
  }

  final MState _initialState;
  late MState _state;

  late final PublishSubject<MState> _stateController;
  final PublishSubject<MocEvent> _eventController = PublishSubject<MocEvent>();

  /// This method is used to transform a new Event in new States
  Stream<MState> changeStateFromEvent(MocEvent event, MState state);

  /// THis method should be called when you want to dispatch a new event
  /// The sate mutation when this method is called is handle for `changeStateFromEvent`
  void dispatch(MocEvent<MState> event) {
    _eventController.add(event);
  }

  bool get isClosed => _stateController.isClosed;

  /// Close the _stateController and _eventController
  /// Use this method when you want to close the provider
  @mustCallSuper
  void close() {
    _stateController.close();
    _eventController.close();
  }

  /// Return the current state
  MState get state => _state;

  /// Method is called when an error is thrown
  void onError(Object err, StackTrace? stackTrace) {
    AppLogger().e(err.toString(), stackTrace: stackTrace);
  }

  /// Method that transform the event stream into a state stream
  ///
  /// 1- `asyncExpand`: The event stream is expand to be able to end a event processing until start the next one
  /// 2-  transform the event with `changeStateFromEvent`
  /// 3- `forEach`: Add the new state to _setState and _stateController
  void _eventControllerTransformer() {
    _eventController.stream.asyncExpand((event) => changeStateFromEvent(event, _state).handleError(onError)).forEach((nextState) {
      if (_stateController.isClosed) return;
      _state = state;
      _stateController.add(nextState);
    });
  }
}

///  This abstract class is used to define a new [Event]
///  The Events are used to change the state of the [Moc]
abstract class MocEvent<MState extends Equatable> {
  const MocEvent();

  @override
  String toString();
}
