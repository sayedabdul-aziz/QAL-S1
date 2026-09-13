import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:greenmart/core/styles/app_colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';
import 'package:greenmart/core/widgets/main_button.dart';
import 'package:greenmart/features/product_details/widgets/quantity_price_row.dart';
import 'package:greenmart/features/product_details/widgets/review_row.dart';
import 'package:greenmart/features/shop/data/dummy_data.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: offersList.length,
        itemBuilder: (context, index) {
          var product = offersList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Image.network(product.image, width: 80, height: 80),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyles.body.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  product.unit,
                                  style: TextStyles.caption1.copyWith(
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),

                      const Gap(12),
                      QuantityPriceRow(
                        quantity: 2,
                        onDecrement: () {},
                        onIncrement: () {},
                        price: product.price,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const Divider(color: AppColors.borderColor),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
        child: MainButton(
          text: 'Checkout',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: AppColors.whiteColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              // enableDrag: false,
              // isDismissible: false,
              isScrollControlled: true,
              useSafeArea: true,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.7,
                minHeight: MediaQuery.sizeOf(context).height * 0.4,
              ),
              builder: (context) => Container(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Text('Reviews', style: TextStyles.body),
                          const Spacer(),
                          CloseButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),

                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                      const ReviewRow(rating: 2),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
