// objects, enums, and constants

class CounterState {}

class CounterInitial extends CounterState {}

class CounterLoadingState extends CounterState {}

class CounterUpdatedState extends CounterState {
  final int counter;

  CounterUpdatedState({required this.counter});
}
