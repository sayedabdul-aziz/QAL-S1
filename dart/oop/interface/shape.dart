import 'dart:math';

mixin Draw {
  //
  void draw() {
    print("Drawing");
  }
}
mixin Color {
  //
  void color() {
    print("Coloring");
  }
}

abstract class Area {
  void getArea(); // abstract method
}

abstract class Perimeter {
  void getPerimeter();
}

class Circle with Draw, Color implements Area, Perimeter {
  int radius;
  Circle(this.radius);

  @override
  void getArea() {
    print("Area is ${pi * radius * radius}");
  }

  @override
  void getPerimeter() {
    print("Perimeter is ${2 * pi * radius}");
  }
}

// PaymentMethod (abstract class) => pay();
// Cash (concrete class) => pay();
// Card (concrete class) => pay();
// wallet (concrete class) => pay();
