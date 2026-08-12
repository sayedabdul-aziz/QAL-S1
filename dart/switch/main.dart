import 'dart:io';

void main() {
  // take input from user

  while (true) {
    print("Enter two numbers: ");
    int x = int.tryParse(stdin.readLineSync() ?? "") ?? 0;
    int y = int.tryParse(stdin.readLineSync() ?? "") ?? 0;

    print("Enter the operator(+, -, *, /):");
    String? ope = stdin.readLineSync();
    switch (ope) {
      case "+":
        print(x + y);
        break;
      case "-":
        print(x - y);
        break;
      case "*":
        print(x * y);
        break;
      case "/":
        print(x / y);
        break;
      default:
        print("Error");
    }

    print("Do you want to continue? (y/n)");
    String? choice = stdin.readLineSync();
    if (choice == "n") {
      break;
    }
  }
}
