import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'base/moc_state_management.dart';
import 'moc_provider.dart';

typedef MBuilder<M extends Moc<MState>, MState extends Equatable> = Widget Function(M moc, MState state);

typedef MListener<M extends Moc, MState> = void Function(M moc, MState state);

class MocBuilder<M extends Moc<MState>, MState extends Equatable> extends StatefulWidget {
  const MocBuilder({
    super.key,
    this.listener,
    required this.builder,
    this.moc,
  });

  final MListener<M, MState>? listener;
  final MBuilder<M, MState> builder;
  final M? moc;

  @override
  State<MocBuilder<M, MState>> createState() => _MocBuilderState<M, MState>();
}

class _MocBuilderState<M extends Moc<MState>, MState extends Equatable> extends State<MocBuilder<M, MState>> {
  StreamSubscription<MState>? _subscription;
  MState? _previousState;
  late M _moc;

  @override
  void initState() {
    super.initState();
    _moc = widget.moc ?? MocProvider.of<M>(context);
    _subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MState>(
      initialData: _moc.state,
      stream: _moc.stateStream,
      builder: (_, snapshot) {
        return widget.builder(_moc, snapshot.requireData);
      },
    );
  }

  @override
  void didUpdateWidget(MocBuilder<M, MState> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.moc != widget.moc) {
      _moc = widget.moc ?? MocProvider.of<M>(context);

      _unsubscribe();
      _subscribe();
    }
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    if (widget.listener == null) return;
    _subscription = _moc.stateStream.listen((state) {
      if (_previousState != state) {
        widget.listener?.call(_moc, state);
        _previousState = state;
      }
    });
  }

  void _unsubscribe() {
    _subscription?.cancel();
  }
}
