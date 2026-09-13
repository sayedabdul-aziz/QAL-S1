import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:greenmart/core/styles/app_colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';
import 'package:greenmart/core/widgets/main_button.dart';
import 'package:greenmart/features/product_details/widgets/nutritions_row.dart';
import 'package:greenmart/features/product_details/widgets/product_detail_section.dart';
import 'package:greenmart/features/product_details/widgets/product_title_row.dart';
import 'package:greenmart/features/product_details/widgets/quantity_price_row.dart';
import 'package:greenmart/features/product_details/widgets/review_row.dart';
import 'package:greenmart/features/shop/data/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(backgroundColor: const Color(0xFFF2F3F2), elevation: 0),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0xFFF2F3F2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Hero(
                  tag: widget.product.heroTag,
                  child: Image.network(
                    widget.product.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(16),
                  ProductTitleRow(name: widget.product.name),
                  const Gap(4),
                  Text(
                    widget.product.unit,
                    style: TextStyles.body.copyWith(color: AppColors.greyColor),
                  ),
                  const Gap(24),
                  QuantityPriceRow(
                    quantity: quantity,
                    price: widget.product.price,
                    onIncrement: () => setState(() => quantity++),
                    onDecrement: () {
                      if (quantity > 1) setState(() => quantity--);
                    },
                  ),
                  const Gap(24),
                  const Divider(color: AppColors.borderColor),
                  ProductDetailSection(description: widget.product.description),
                  const Divider(color: AppColors.borderColor),
                  NutritionsRow(nutrition: widget.product.nutrition),
                  const Divider(color: AppColors.borderColor),
                  ReviewRow(rating: widget.product.rating),
                  const Gap(16),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
        child: MainButton(text: 'Add To Cart', onPressed: () {}),
      ),
    );
  }
}
