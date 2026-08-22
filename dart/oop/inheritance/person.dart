mixin Greeting {
  void greet() {
    print("Hello");
  }
}

class Person {
  String? name;
  int? id;

  Person({required this.id, required this.name});

  void display() {
    print("Name: $name , ID: $id");
  }
}

class Student extends Person with Greeting {
  String? grade;
  Student({required super.name, required super.id, required this.grade});
  // Student({required String name, required int id, required this.grade})
  //   : super(name: name, id: id);
  @override
  display() {
    print("Name: $name , ID: $id, Grade: $grade");
  }
}

class Doctor extends Person {
  double? salary;

  Doctor({required super.name, required super.id, required this.salary});

  @override
  display() {
    print("Name: $name , ID: $id, Salary: $salary");
  }
}
