import 'package:dart_subject/dart_subject.dart';

class SubjectContainer {
  /// defining a subject
  var countSubject = Subject<int>();
}

class CounterObserver implements Observer {
  CounterObserver(Function(Observer) unsubscribe) {
    unsubscribe = unsubscribe;
  }
  int count = 0;

  @override
  void update(observable) {
    switch (observable.runtimeType) {
      case int:
        count = observable;
      default:
        break;
    }
  }

  @override
  void deinit() {
    unsubscribe(this);
  }

  @override
  late Function(Observer) unsubscribe;
}

class CounterEmitter extends Emitter {
  CounterEmitter(super._emitInject);
  int currentCount = 0;

  void increment() {
    currentCount++;
    super.emit(currentCount);
  }

  void decrement() {
    currentCount--;
    super.emit(currentCount);
  }
}

void main() {
  var subjectContainer = SubjectContainer();

  var observer = CounterObserver(subjectContainer.countSubject.removeObserver);
  subjectContainer.countSubject.addObserver(observer);
  var emitter = CounterEmitter(subjectContainer.countSubject.notifyObservers);
  print("OBSERVERS: ${subjectContainer.countSubject.observers.toString()}");
  print("INITIAL: ${observer.count}");
  emitter.increment();
  print("INCREMENTED: ${observer.count}");
  emitter.decrement();
  print("DECREMENTED: ${observer.count}");
  observer.deinit();
  print("OBSERVERS: ${subjectContainer.countSubject.observers.toString()}");
}
