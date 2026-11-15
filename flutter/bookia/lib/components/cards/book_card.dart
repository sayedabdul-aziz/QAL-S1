import 'package:bookia/core/routes/naviagtions.dart';
import 'package:bookia/core/routes/route_names.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/features/home/presentation/widgets/best_sellers_books.dart';
import 'package:bookia/features/wishlist/presentation/wishlist_action/widgets/wishlist_action.dart';
import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  const BookCard({super.key, required this.product, this.onItemRemoved});
  final Product product;
  final Function(int)? onItemRemoved;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.product.id != null
          ? () {
              pushTo(
                context,
                RouteNames.details,
                extra: widget.product.id,
              ).then((value) {
                // if item in the wishlist is removed
                bool isInWishlist = SharedPref.getWishlist().contains(
                  widget.product.id,
                );
                setState(() {});
                if (!isInWishlist) {
                  widget.onItemRemoved?.call(widget.product.id ?? 0);
                }
              });
            }
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.product.image ?? '',
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
                Positioned(
                  top: 0,
                  right: 0,
                  child: WishlistAction(
                    productId: widget.product.id ?? 0,
                    onRemoved: widget.onItemRemoved,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(
                widget.product.name ?? '',
                style: TextStyles.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Text(
                  '\$${widget.product.priceAfterDiscount ?? widget.product.price}',
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
