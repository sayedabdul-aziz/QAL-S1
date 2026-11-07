import 'package:bookia/core/routes/naviagtions.dart';
import 'package:bookia/core/routes/route_names.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/features/home/presentation/widgets/best_sellers_books.dart';
import 'package:bookia/features/wishlist/presentation/wishlist_action/widgets/wishlist_action.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.product, this.onItemRemoved});
  final Product product;
  final Function(int)? onItemRemoved;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: product.id != null
          ? () => pushTo(context, RouteNames.details, extra: product.id)
          : null,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: LightPalette.whiteColor,
          border: Border.all(color: LightPalette.borderColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'book-cover-${product.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.image ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: cardHeight * .6,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: cardHeight * .6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: LightPalette.borderColor,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: WishlistAction(
                    productId: product.id ?? 0,
                    onRemoved: onItemRemoved,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(
                product.name ?? '',
                style: TextStyles.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Text(
                  '\$${product.priceAfterDiscount ?? product.price}',
                  style: TextStyles.subtitle,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: LightPalette.primaryColor,
                  ),
                  child: const Icon(Icons.add, color: LightPalette.whiteColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
