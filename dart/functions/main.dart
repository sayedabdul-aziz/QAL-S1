// ex: write function to get power of a number
// 2(3) ==> 2*2*2
// int power (int base, int exp)

void main() {
  // display("Ahmed", 20, "Egyptian");
  // display1("Ahmed", 20);
  // display2(age: 20, nationality: "Egyptian", name: "Ahmed");
  display3(age: 20, name: "Ahmed");
  display4("Ahmed", age: 20);
}

// 1) Positional parameters. (Ordered , Required)
void display(String name, int age, String nationality) {
  print("Name: $name , Age: $age, Nationality: $nationality");
}

// 2) Positional parameters. (Ordered , Required - Optional)
void display1(String name, int age, [String nationality = "Egyptian"]) {
  print("Name: $name , Age: $age, Nationality: $nationality");
}

// 3) Named parameters. (Unordered , Required)
void display2({
  required String name,
  required int age,
  required String nationality,
}) {
  print("Name: $name , Age: $age, Nationality: $nationality");
}

// 3) Named parameters. (Unordered , Required - Optional)
void display3({
  required String name,
  required int age,
  String nationality = "Egyptian",
}) {
  print("Name: $name , Age: $age, Nationality: $nationality");
}

// 4) Mix parameters. (Unordered , Required - Optional)
void display4(
  String name, {
  required int age,
  String nationality = "Egyptian",
}) {
  print("Name: $name , Age: $age, Nationality: $nationality");
}
