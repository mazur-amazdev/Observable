// ignore: unused_import
import 'dart:io';

abstract class Observer {
  const Observer(this.unsubscribe);

  /// the injected unsubscribe closure to remove from subject
  final Function(Observer) unsubscribe;

  /// the update void that gets triggered
  void update(dynamic observable);

  /// the deinit forced to be called
  void deinit() {
    unsubscribe(this);
  }
}
