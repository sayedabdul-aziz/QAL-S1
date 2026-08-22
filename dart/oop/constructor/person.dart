class Person {
  // attr.
  String? name;
  int? age;
  Gender? gender;
  int? status; //

  // Constructor
  Person({
    required this.name,
    required this.age,
    required this.gender,
    this.status = 0,
  });
  // named constructor
  Person.setName({required this.name});

  //methods
  void display() {
    print("Name: $name , Age: $age, Gender: $gender");
  }
}

// overloading(dart) vs overriding

enum Gender { Male, Female }

// avoid magic numbers (1,2,3,4)
// backend (int) => flutter (enum) => send to backend(int)

enum PaymentStatus {
  Pending(1),
  Approved(2),
  Rejected(3),
  Cancelled(4);

  final int value;
  const PaymentStatus(this.value);

  PaymentStatus? fromInt(int? value) {
    switch (value) {
      case 1:
        return PaymentStatus.Pending;
      case 2:
        return PaymentStatus.Approved;
      case 3:
        return PaymentStatus.Rejected;
      case 4:
        return PaymentStatus.Cancelled;
      default:
        return null;
    }
  }
}
