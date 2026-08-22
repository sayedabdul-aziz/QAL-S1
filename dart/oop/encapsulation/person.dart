class Person {
  String? name;
  int? _age;
  String? gender;
  double _balance = 0;

  void setAge(int age) {
    if (age <= 0) {
      throw Exception("Age must be greater than 0");
    } else {
      this._age = age;
    }
  }

  int? get age => this._age;

  double? get balance => this._balance;

  void deposit(double amount) {
    if (amount <= 0) {
      throw Exception("Amount must be greater than 0");
    }
    if (amount > 100000) {
      throw Exception("Amount must be less than 100000");
    }
    this._balance = this._balance + amount;
  }
}
