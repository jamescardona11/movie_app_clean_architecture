// ignore_for_file: unused_element

import 'package:flutter/material.dart';

import 'moc_provider.dart';
import 'moc_state_management.dart';

/// MocProvider extension help to access the [Moc] methods using the context

extension MocProviderX on BuildContext {
  D read<D extends Moc>() {
    return MocProvider.read<D>(this);
  }

  D watch<D extends Moc>() {
    return MocProvider.watch<D>(this);
  }
}
