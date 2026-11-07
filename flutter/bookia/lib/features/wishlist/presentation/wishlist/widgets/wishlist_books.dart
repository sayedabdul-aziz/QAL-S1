import 'package:bookia/components/cards/book_card.dart';
import 'package:bookia/components/shimmer/shimmer.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/features/wishlist/presentation/wishlist/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/wishlist/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

const cardHeight = 320.0;

class WishlistBooks extends StatefulWidget {
  const new({super.key});

  @override
  State<WishlistBooks> createState() => _WishlistBooksState();
}

class _WishlistBooksState extends State<WishlistBooks> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        if (state is WishlistLoadingState || state is WishlistErrorState) {
          return ShimmerGridView(
            itemCount: 4,
            mainAxisExtent: cardHeight,
            itemBuilder: (context, index) => BookCard(product: Product()),
          );
        }
        var books = context.read<WishlistCubit>().products;
        if (books.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bookmark_border,
                  size: 64,
                  color: LightPalette.primaryColor,
                ),
                const Gap(12),
                Text(
                  'Your wishlist is empty',
                  style: TextStyles.body.copyWith(
                    color: LightPalette.greyColor,
                  ),
                ),
              ],
            ),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            mainAxisExtent: cardHeight,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            return BookCard(
              product: books[index],
              onItemRemoved: (id) {
                books.removeWhere((element) => element.id == id);
                setState(() {});
              },
            );
          },
        );
      },
    );
  }
}
