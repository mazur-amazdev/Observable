// ignore: unused_import
import 'dart:io';

import 'observer.dart';

/// The Subject
class Subject<T> {
  /// the observers list on which we can subscribe
  List<Observer> observers = [];

  /// the add observers function that is needed to be informed
  void addObserver(Observer observer) {
    observers.add(observer);
    // observer.subject = this;
  }

  /// notify each observer for this subject
  void notifyObservers(dynamic element) {
    for (var oberserver in observers) {
      oberserver.update(element);
    }
  }

  /// remove an observer for deinit
  void removeObserver(Observer observer) {
    observers.remove(observer);
  }
}
