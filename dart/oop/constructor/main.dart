import 'person.dart';

void main() {
  // POSITIONAL PARAMETERS AND NAMED PARAMETERS
  Person p1 = Person(
    age: 20,
    name: "Ahmed",
    gender: Gender.Male,
    status: PaymentStatus.Approved.value,
  );
  p1.display();
  Person p2 = Person.setName(name: "Ahmed");
  p2.display();
}
