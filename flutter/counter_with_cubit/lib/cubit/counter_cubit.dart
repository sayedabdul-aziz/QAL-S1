import 'package:counter_with_cubit/cubit/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  int counter = 0;

  Future<void> increment() async {
    emit(CounterLoadingState());
    await Future.delayed(Duration(seconds: 1));
    counter++;
    emit(CounterUpdatedState(counter: counter));
  }

  Future<void> decrement() async {
    emit(CounterLoadingState());
    await Future.delayed(Duration(seconds: 1));
    counter--;
    emit(CounterUpdatedState(counter: counter));
  }

  Future<void> reset() async {
    emit(CounterLoadingState());
    await Future.delayed(Duration(seconds: 1));
    counter = 0;
    emit(CounterUpdatedState(counter: counter));
  }
}

// Polymorphism

// Shape (Circle, Rectangle)
// Circle extends Shape
// Rectangle extends Shape

// getArea(Shape s){
// any shape will have area
// }

// Shape s = Circle();
// s = Rectangle();
