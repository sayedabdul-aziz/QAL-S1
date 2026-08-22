import 'dart:math';

abstract class Shape {
  void getArea(); // abstract method
  display() {
    // concrete method
    print("Shape");
  }
}

class Rectangle extends Shape {
  int width;
  int height;

  Rectangle(this.width, this.height);

  @override
  void getArea() {
    print("Area is ${width * height}");
  }
}

class Circle extends Shape {
  int radius;
  Circle(this.radius);

  @override
  void getArea() {
    print("Area is ${pi * radius * radius}");
  }
}

// PaymentMethod (abstract class) => pay();
// Cash (concrete class) => pay();
// Card (concrete class) => pay();
// wallet (concrete class) => pay();
