// ignore: unused_import
import 'dart:io';

mixin Observer {
  /// the injected unsubscribe closure to remove from subject
  late final Function(Observer) unsubscribe;

  /// the update void that gets triggered
  void update(dynamic observable);

  /// the deinit forced to be called
  void deinit() {
    unsubscribe(this);
  }
}
