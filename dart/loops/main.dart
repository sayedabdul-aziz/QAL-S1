void main() {
  for (int m = 0; m < 10; m++) {
    if (m == 4) {
      continue;
    }
    for (int s = 0; s < 60; s++) {
      print("$m:$s");
    }
  }

  // factorial (5*4*3*2*1)
  // int number = 6;
  // int fact = 1;

  // for (int i = number; i > 0; i--) {
  //   fact *= i; // 6*5*4*3*2*1
  // }

  // int i = number;
  // while (i > 0) {
  //   fact *= i;
  //   i--;
  // }

  // int i = number;
  // do {
  //   fact *= i;
  //   i--;
  // } while (i > 0);

  // print(fact);
}
