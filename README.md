# DartSubject

## Features

Observe and emit through different contextes. Be aware that you should be able to track the deinitialization to remove observes from a subject to prevent memoryleaks.


## Usage

I recommend to build a SubjectContainer, to be fully aware of the used subject throughout your applications an be sure each observer and emitter are connected to the same subject to achieve getting infos in different contexts.

```dart
import 'package:observable/DartSubject.dart';
/// the subject container
class SubjectContainer {
  /// defining a subject
  var countSubject = Subject<int>();
}
```

In the next step define a class that wants to be able to observe a value in this case it observes an integer.

```dart 
/// the counter observer
class CounterObserver extends Observer {
    /// call the super constructor with the unsubcribe function
    CounterObserver(super.unsubscribe);
    /// the count variable that is updated by observing a subject
    int count = 0;

    @override
    void update(observable) {
        /// get a dynamic type observable and check by runtime type
        switch (observable.runtimeType) {
            /// in this case we only subscribed to one observable ande proceed with logic if case int is true
            case int:
                /// update our count variable
                count = observable;
            default:
                break;
        }
    }
}
```

For having a useful observer we need someone that wants to emit via the defined subject 

```dart
/// the counter emitter
class CounterEmitter extends Emitter {
    /// the super counter emitter constructor called
    CounterEmitter(super._emitInject);
    /// the count we want to emit via the subject
    int currentCount = 0;

    // increment and emit
    void increment() {
        currentCount++;
        super.emit(currentCount);
    }

    // decrement and emit
    void decrement() {
        currentCount--;
        super.emit(currentCount);
    }
}
```
and the usage in the application would look something like that in a simple way, but is able to launch emits through different contexts via dependency injection by the subject container
```dart
/// application starting point
void main() {
    /// initialize the subject container
    var subjectContainer = SubjectContainer();
    /// the observer getting the remove injected
    var observer = CounterObserver(subjectContainer.countSubject.removeObserver);
    /// and subject container add the observer to its list of observers to notify
    subjectContainer.countSubject.addObserver(observer);
    /// the emitter get the notify observers injected to pump changes via the subject
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
```