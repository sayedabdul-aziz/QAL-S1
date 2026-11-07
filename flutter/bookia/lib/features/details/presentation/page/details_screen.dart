import 'package:bookia/components/main_app_bar.dart';
import 'package:bookia/components/shimmer/shimmer.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/details/presentation/cubit/details_cubit.dart';
import 'package:bookia/features/details/presentation/cubit/details_state.dart';
import 'package:bookia/features/wishlist/presentation/wishlist_action/widgets/wishlist_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailsCubit>().getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        actions: [WishlistAction(productId: widget.productId)],
      ),
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoadingState) {
            return _DetailsShimmer(productId: widget.productId);
          }

          if (state is DetailsErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, style: TextStyles.body),
                  const Gap(16),
                  TextButton(
                    onPressed: () => context
                        .read<DetailsCubit>()
                        .getProductDetails(widget.productId),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final product = context.read<DetailsCubit>().product;

          return Column(
            children: [
              // ── scrollable content ───────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // book cover
                      const Gap(24),
                      Center(
                        child: Hero(
                          tag: 'book-cover-${widget.productId}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product?.image ?? '',
                              height: 300,
                              width: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => Container(
                                height: 300,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: LightPalette.borderColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(24),
                      // title
                      Text(
                        product?.name ?? '',
                        style: TextStyles.title1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const Gap(6),

                      // category
                      Text(
                        product?.category ?? '',
                        style: TextStyles.body.copyWith(
                          color: LightPalette.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const Gap(16),

                      // description
                      Text(
                        product?.description ?? '',
                        style: TextStyles.body.copyWith(
                          color: LightPalette.greyColor,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.justify,
                      ),

                      const Gap(32),
                    ],
                  ),
                ),
              ),

              // ── bottom bar ───────────────────────────────────────────
              _BottomBar(
                price:
                    product?.priceAfterDiscount?.toString() ??
                    product?.price ??
                    '',
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── shimmer skeleton ─────────────────────────────────────────────────────────

class _DetailsShimmer extends StatelessWidget {
  const _DetailsShimmer({required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // top nav placeholder
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextShimmer(width: 42, height: 42, borderRadius: 21),
              TextShimmer(width: 28, height: 28, borderRadius: 8),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // book cover — Hero placeholder keeps the animation landing target
                Center(
                  child: Hero(
                    tag: 'book-cover-$productId',
                    child: TextShimmer(
                      width: 200,
                      height: 300,
                      borderRadius: 12,
                    ),
                  ),
                ),
                const Gap(24),
                TextShimmer(width: 260, height: 28),
                const Gap(10),
                TextShimmer(width: 120, height: 18),
                const Gap(20),
                ...List.generate(
                  5,
                  (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextShimmer(
                      width: i == 4 ? 220 : double.infinity,
                      height: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // bottom bar shimmer
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Row(
            children: [
              TextShimmer(width: 80, height: 28),
              const Spacer(),
              TextShimmer(width: 160, height: 52, borderRadius: 14),
            ],
          ),
        ),
      ],
    );
  }
}

// ── bottom bar ───────────────────────────────────────────────────────────────

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.price});

  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            '\$$price',
            style: TextStyles.title2.copyWith(
              fontWeight: FontWeight.bold,
              color: LightPalette.textPrimary,
            ),
          ),
          SizedBox(
            height: 52,
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: LightPalette.textPrimary,
                foregroundColor: LightPalette.whiteColor,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                'Add To Cart',
                style: TextStyles.body.copyWith(
                  color: LightPalette.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
