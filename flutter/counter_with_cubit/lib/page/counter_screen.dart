import 'package:counter_with_cubit/bloc/counter_bloc.dart';
import 'package:counter_with_cubit/bloc/counter_bloc_event.dart';
import 'package:counter_with_cubit/bloc/counter_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<CounterBloc>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            BlocConsumer<CounterBloc, CounterBlocState>(
              listener: (context, state) {
                if (state is CounterUpdatedState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Counter Updated")));
                }
              },
              builder: (context, state) {
                // when state changes, rebuild ui state.counter

                if (state is CounterLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is CounterUpdatedState) {
                  return Text(
                    state.counter.toString(),
                    style: TextStyle(fontSize: 80),
                  );
                } else {
                  return Text("0", style: TextStyle(fontSize: 80));
                }
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                  onPressed: () {
                    bloc.add(IncrementEvent());
                  },
                  icon: Icon(Icons.add),
                ),
                SizedBox(width: 20),
                IconButton.filled(
                  onPressed: () {
                    bloc.add(ResetEvent());
                  },
                  icon: Icon(Icons.refresh),
                ),
                SizedBox(width: 20),
                IconButton.filled(
                  onPressed: () {
                    bloc.add(DecrementEvent());
                  },
                  icon: Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Builder (rebuild ui when state changes)
// Listener (listen to state changes and take actions (navigation, snackbar, etc))
// Consumer (rebuild ui when state changes and take actions (navigation, snackbar, etc))
