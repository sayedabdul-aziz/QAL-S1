import 'package:bookia/components/shimmer/shimmer_list_view.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/presentation/cart/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cart/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/cart/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartItems extends StatefulWidget {
  const CartItems({super.key});

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoadingState || state is CartErrorState) {
          return ShimmerListView(
            itemCount: 4,
            padding: const EdgeInsets.symmetric(vertical: 8),
            separatorBuilder: (context, _) => const Gap(12),
            itemBuilder: (context, _) => _CartItemSkeleton(),
          );
        }

        final items = context.read<CartCubit>().cartItems;

        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 64,
                  color: LightPalette.primaryColor,
                ),
                const Gap(12),
                Text(
                  'Your cart is empty',
                  style: TextStyles.body.copyWith(
                    color: LightPalette.greyColor,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length,
          separatorBuilder: (context, _) => const Gap(12),
          itemBuilder: (context, index) {
            final CartItem item = items[index];
            return CartItemCard(
              item: item,
              onRemoved: (productId) {
                items.removeWhere((e) => e.itemProductId == productId);
                setState(() {});
              },
              onQuantityChanged: () {},
            );
          },
        );
      },
    );
  }
}

/// Skeleton placeholder shown during loading.
class _CartItemSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: LightPalette.borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 16,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
                Container(height: 14, width: 80, color: Colors.grey.shade300),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 32,
                    width: 110,
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
