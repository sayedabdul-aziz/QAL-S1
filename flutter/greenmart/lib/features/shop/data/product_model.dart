class ProductModel {
  final int id;
  final String name;
  final double price;
  final String image;
  final String unit;
  final String description;
  final double rating;
  final String nutrition;
  final String heroTag;
  final int categoryId;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.unit,
    this.description =
        'Apples Are Nutritious. Apples May Be Good For Weight Loss. Apples May Be Good For Your Heart. As Part Of A Healtful And Varied Diet.',
    this.rating = 5.0,
    this.nutrition = '100gr',
    required this.heroTag,
    required this.categoryId,
  });
}
