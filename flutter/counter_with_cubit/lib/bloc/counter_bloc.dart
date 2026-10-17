import 'package:counter_with_cubit/bloc/counter_bloc_event.dart';
import 'package:counter_with_cubit/bloc/counter_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterBlocState> {
  CounterBloc() : super(CounterInitial()) {
    // sink events
    on((event, emit) async {
      if (event is IncrementEvent) {
        await increment(emit);
      } else if (event is DecrementEvent) {
        await decrement(emit);
      } else if (event is ResetEvent) {
        await reset(emit);
      }
    });
  }

  int counter = 0;

  Future<void> increment(Emitter<CounterBlocState> emit) async {
    emit(CounterLoadingState());
    await Future.delayed(Duration(seconds: 1));
    counter++;
    emit(CounterUpdatedState(counter: counter));
  }

  Future<void> decrement(Emitter<CounterBlocState> emit) async {
    emit(CounterLoadingState());
    await Future.delayed(Duration(seconds: 1));
    counter--;
    emit(CounterUpdatedState(counter: counter));
  }

  Future<void> reset(Emitter<CounterBlocState> emit) async {
    emit(CounterLoadingState());
    await Future.delayed(Duration(seconds: 1));
    counter = 0;
    emit(CounterUpdatedState(counter: counter));
  }
}
