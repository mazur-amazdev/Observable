// ignore: unused_import
import 'dart:io';

abstract class Emitter {
  Emitter(this._emitInject);

  final Function(dynamic) _emitInject;

  void emit(dynamic emit) {
    _emitInject(emit);
  }
}
