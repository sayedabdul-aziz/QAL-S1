import 'package:bookia/components/main_app_bar.dart';
import 'package:bookia/components/shimmer/shimmer.dart';
import 'package:bookia/core/constants/app_design.dart';
import 'package:bookia/core/routes/naviagtions.dart';
import 'package:bookia/core/routes/route_names.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/features/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/features/search/presentation/cubit/search_state.dart';
import 'package:bookia/features/wishlist/presentation/wishlist_action/widgets/wishlist_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      context.read<SearchCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightPalette.background,
      appBar: MainAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── search field ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDesign.CONTENT_PADDING,
            ),
            child: _SearchField(
              controller: _searchController,
              onChanged: (q) => context.read<SearchCubit>().onQueryChanged(q),
            ),
          ),

          const Gap(16),

          // ── results ──────────────────────────────────────────────────
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                // ── initial (nothing typed) ──
                if (state is SearchInitialState) {
                  return _HintView();
                }

                // ── first load shimmer ──
                if (state is SearchLoadingState) {
                  return ShimmerListView(
                    shrinkWrap: false,
                    itemCount: 6,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDesign.CONTENT_PADDING,
                    ),
                    separatorBuilder: (_, _) => const Gap(12),
                    itemBuilder: (_, _) => const _SearchCardShimmer(),
                  );
                }

                // ── error ──
                if (state is SearchErrorState) {
                  return Center(
                    child: Text(state.message, style: TextStyles.body),
                  );
                }

                // ── no results ──
                if (state is SearchEmptyState) {
                  return Center(
                    child: Text(
                      'No books found',
                      style: TextStyles.body.copyWith(
                        color: LightPalette.greyColor,
                      ),
                    ),
                  );
                }

                // ── success / loading more ──
                final cubit = context.read<SearchCubit>();
                final products = cubit.products;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Total: ${cubit.totalProducts}",
                        style: TextStyles.body,
                      ),
                    ),

                    Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(
                          left: AppDesign.CONTENT_PADDING,
                          right: AppDesign.CONTENT_PADDING,
                          bottom: 24,
                        ),
                        itemCount:
                            products.length +
                            (state is SearchLoadingMoreState ? 1 : 0),
                        separatorBuilder: (_, _) => const Gap(12),
                        itemBuilder: (context, index) {
                          if (index == products.length) {
                            // bottom pagination spinner
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          return _SearchBookCard(product: products[index]);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── search field ─────────────────────────────────────────────────────────────

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyles.body,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyles.body.copyWith(color: LightPalette.greyColor),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: LightPalette.greyColor,
        ),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (_, value, _) => value.text.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: LightPalette.greyColor,
                  ),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                ),
        ),
        filled: true,
        fillColor: LightPalette.whiteColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: LightPalette.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: LightPalette.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: LightPalette.primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

// ── book card ─────────────────────────────────────────────────────────────────

class _SearchBookCard extends StatelessWidget {
  const _SearchBookCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final price = product.priceAfterDiscount?.toString() ?? product.price ?? '';

    return GestureDetector(
      onTap: product.id != null
          ? () => pushTo(context, RouteNames.details, extra: product.id)
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
              tag: 'book-cover-${product.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.image ?? '',
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
                            product.name ?? '',
                            style: TextStyles.subtitle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap(8),
                        // wishlist action
                        WishlistSmallAction(productId: product.id ?? 0),
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

// ── search card shimmer ───────────────────────────────────────────────────────

class _SearchCardShimmer extends StatelessWidget {
  const _SearchCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: LightPalette.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: LightPalette.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextShimmer(width: 100, height: 120, borderRadius: 8),
          const Gap(12),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextShimmer(width: double.infinity, height: 18),
                      const Gap(8),
                      TextShimmer(width: 140, height: 18),
                    ],
                  ),
                  Row(
                    children: [
                      TextShimmer(width: 60, height: 20),
                      const Spacer(),
                      TextShimmer(width: 72, height: 36, borderRadius: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── hint view ─────────────────────────────────────────────────────────────────

class _HintView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_rounded, size: 64, color: LightPalette.borderColor),
          const Gap(12),
          Text(
            'Search for books by name',
            style: TextStyles.body.copyWith(color: LightPalette.greyColor),
          ),
        ],
      ),
    );
  }
}
