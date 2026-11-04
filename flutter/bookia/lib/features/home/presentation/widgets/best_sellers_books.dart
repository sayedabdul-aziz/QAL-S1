import 'package:bookia/components/shimmer/shimmer.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/components/cards/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

const cardHeight = 320.0;

class BestSellersBooks extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState || state is HomeErrorState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextShimmer(width: 200, height: 20),
              const Gap(8),
              ShimmerGridView(
                shrinkWrap: true,
                itemCount: 4,
                mainAxisExtent: cardHeight,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => BookCard(product: Product()),
              ),
            ],
          );
        }
        var books = context.read<HomeCubit>().bestSellerBooks;
        if (books.isEmpty) {
          return SizedBox();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Best Sellers', style: TextStyles.title1),
            const Gap(8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: cardHeight,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                return BookCard(product: books[index]);
              },
            ),
          ],
        );
      },
    );
  }
}
