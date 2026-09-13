import 'package:greenmart/features/shop/data/dummy_data.dart';
import 'package:greenmart/features/shop/data/product_model.dart';

class CategoryModel {
  final int id;
  final String name;
  final String image;

  CategoryModel({required this.id, required this.name, required this.image});
}

var categoriesList = [
  CategoryModel(id: 1, name: 'Fruits', image: 'assets/images/fruits.png'),
  CategoryModel(
    id: 2,
    name: 'Vegetables',
    image: 'assets/images/vegitables.png',
  ),
  CategoryModel(id: 3, name: 'Grains', image: 'assets/images/grains.png'),
  CategoryModel(id: 4, name: 'Dairy', image: 'assets/images/dairy.png'),
];

List<ProductModel> getProductsByCategory(int categoryId) {
  return allProducts
      .where((product) => product.categoryId == categoryId)
      .toList();
}
