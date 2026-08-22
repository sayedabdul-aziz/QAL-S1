import 'person.dart';

void main(List<String> args) {
  Student s1 = Student(id: 4, name: "Ahmed", grade: 'A');

  s1.display();

  Doctor d1 = Doctor(id: 4, name: "Ahmed", salary: 1000);

  d1.display();
}
