import 'shape.dart';

void main(List<String> args) {
  Shape c1 = Circle(5);
  getArea(c1);

  Shape r1 = Rectangle(5, 10);
  getArea(r1);
}

// shape => circle, rectangle

getArea(Shape shape) {
  shape.getArea();
}
