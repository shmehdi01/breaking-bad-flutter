abstract class BlocState  {

}

abstract class BlocEvent {

}

abstract class ErrorState {
  final String message;
  final int code;

  ErrorState(this.message, this.code);
}

class LoadingState {

}