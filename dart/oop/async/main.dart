void main() async {
  print("task 1");
  await doTask2();
  print("task 3");
}

doTask2() async {
  await Future.delayed(Duration(seconds: 3), () {
    print("task 2");
  });
}
