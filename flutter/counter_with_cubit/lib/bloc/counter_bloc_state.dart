// objects, enums, and constants

class CounterBlocState {}

class CounterInitial extends CounterBlocState {}

class CounterLoadingState extends CounterBlocState {}

class CounterUpdatedState extends CounterBlocState {
  final int counter;

  CounterUpdatedState({required this.counter});
}
