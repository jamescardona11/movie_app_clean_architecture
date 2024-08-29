import 'package:flutter/widgets.dart';

import 'base/moc_state_management.dart';

/// MocProvider is a [InheritedWidget] that provides the [Moc] to its children
/// The [Moc] is created using the [create] function
/// Children can access the [Moc] using the [Moc>Provider.of] method or using BuildContext extension
typedef DCreate<D extends Moc> = D Function(BuildContext context);

class MocProvider<D extends Moc> extends StatefulWidget {
  const MocProvider({
    super.key,
    required this.create,
    required this.child,
  });

  final DCreate<D> create;
  final Widget child;

  @override
  State<MocProvider<D>> createState() => _MocProviderState<D>();

  static D of<D extends Moc>(BuildContext context, {bool listen = false}) {
    if (D == dynamic) {
      throw _ProviderError();
    }

    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<_MocProviderIW<D>>()
        : (context.getElementForInheritedWidgetOfExactType<_MocProviderIW<D>>()?.widget as _MocProviderIW<D>?);

    if (provider == null) {
      throw _ProviderError(D);
    }

    return provider.moc;
  }

  /// Method to access to the [Moc] using the context
  static D read<D extends Moc>(BuildContext context) {
    return of<D>(context);
  }

  /// Method to watch changes in the [Moc] using the context
  static D watch<D extends Moc>(BuildContext context) {
    return of<D>(context, listen: true);
  }

  /// Method to dispatch an event to the [Moc] using the context
  static void dispatch<D extends Moc>(
    BuildContext context,
    MocEvent event,
  ) {
    return of<D>(context).dispatch(event);
  }
}

class _MocProviderState<D extends Moc> extends State<MocProvider<D>> {
  late D moc;

  @override
  void initState() {
    super.initState();
    moc = widget.create(context);
  }

  @override
  Widget build(BuildContext context) {
    return _MocProviderIW(
      moc: moc,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    moc.close();
    super.dispose();
  }
}

class _MocProviderIW<D extends Moc> extends InheritedWidget {
  const _MocProviderIW({
    super.key,
    required super.child,
    required this.moc,
  }) : super();

  final D moc;

  @override
  bool updateShouldNotify(covariant _MocProviderIW<D> oldWidget) => moc != oldWidget.moc;
}

class _ProviderError extends Error {
  /// The type of the class the user tried to retrieve
  final Type? type;

  /// Creates a [_ProviderError]
  _ProviderError([this.type]);

  @override
  String toString() {
    if (type == null) {
      return '''Error: please specify type instead of using dynamic when calling MocProvider.of<T>() or context.get<T>() method.''';
    }

    return '''Error: No Provider<$type> found. To fix, please try:
              * Wrapping your MaterialApp with the MocProvider<$type>.
              * Providing full type information to MocProvider<$type>, MocProvider.of<$type> and context.get<$type>() method.
          ''';
  }
}
