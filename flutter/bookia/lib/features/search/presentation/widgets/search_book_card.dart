import 'package:bookia/core/routes/naviagtions.dart';
import 'package:bookia/core/routes/route_names.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/features/wishlist/presentation/wishlist_action/widgets/wishlist_action.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchBookCard extends StatefulWidget {
  const SearchBookCard({super.key, required this.product});
  final Product product;

  @override
  State<SearchBookCard> createState() => _SearchBookCardState();
}

class _SearchBookCardState extends State<SearchBookCard> {
  @override
  Widget build(BuildContext context) {
    final price =
        widget.product.priceAfterDiscount?.toString() ??
        widget.product.price ??
        '';

    return GestureDetector(
      onTap: widget.product.id != null
          ? () {
              pushTo(
                context,
                RouteNames.details,
                extra: widget.product.id,
              ).then((value) {
                setState(() {});
              });
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: LightPalette.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: LightPalette.borderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── cover image with bookmark overlay ──
            Hero(
              tag: 'book-cover-${widget.product.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.product.image ?? '',
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      color: LightPalette.borderColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),

            const Gap(12),

            // ── info ──
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name ?? '',
                            style: TextStyles.subtitle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap(8),
                        // wishlist action
                        WishlistSmallAction(productId: widget.product.id ?? 0),
                      ],
                    ),
                    // price + buy
                    Row(
                      children: [
                        Text(
                          '\$$price',
                          style: TextStyles.subtitle.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LightPalette.textPrimary,
                              foregroundColor: LightPalette.whiteColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Buy',
                              style: TextStyles.body.copyWith(
                                color: LightPalette.whiteColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
