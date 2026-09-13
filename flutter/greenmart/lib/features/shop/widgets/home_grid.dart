import 'package:flutter/material.dart';
import 'package:greenmart/features/shop/data/product_model.dart';
import 'package:greenmart/features/shop/widgets/product_card.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.list});

  final List<ProductModel> list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 250,
      ),
      itemBuilder: (context, index) {
        var product = list[index];
        return ProductCard(product: product);
      },
      itemCount: list.length,
    );
  }
}
