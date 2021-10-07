import 'dart:async';

import 'base_state.dart';

abstract class BaseBloc<E, S extends BlocState> {
  final StreamController<S> _stateController = StreamController<S>();
  final StreamController<E> _eventController = StreamController<E>();

  Stream<S> get state => _stateController.stream;

  BaseBloc() {
    _eventController.stream.listen((event) {
      mapEventToState(event).listen((event) {
        _stateController.add(event);
      });
    });
  }

  void dispatchEvent(E event) {
    _eventController.sink.add(event);
  }

  Stream<S> mapEventToState(E event);

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}