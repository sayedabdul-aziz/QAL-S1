import 'person.dart';

void main(List<String> args) {
  Person p1 = Person();
  p1.deposit(1000000);
  print(p1.balance);
}
