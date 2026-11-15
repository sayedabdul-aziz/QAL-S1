import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/presentation/cart_action/cubit/cart_action_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
    this.onRemoved,
    this.onQuantityChanged,
  });

  final CartItem item;

  /// Called with the productId after a successful remove — lets the parent
  /// strip the card from the list immediately (offline-first UI update).
  final Function(int productId)? onRemoved;

  /// Called after every successful +/- so the parent can refresh the total.
  final VoidCallback? onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        // Pre-hydrate cubit fields directly from the CartItem object we
        // already have — no cache read needed here.
        final cubit = CartActionCubit();
        cubit.cartItemId = item.itemId ?? 0;
        cubit.stock = item.itemProductStock ?? 0;
        cubit.quantity = item.itemQuantity ?? 1;
        return cubit;
      },
      child: BlocListener<CartActionCubit, CartActionState>(
        listener: (context, state) {
          if (state is CartActionSuccess) {
            onQuantityChanged?.call();
          }
        },
        child: BlocBuilder<CartActionCubit, CartActionState>(
          builder: (context, state) {
            final cubit = context.read<CartActionCubit>();
            return _CartItemCardContent(
              item: item,
              cubit: cubit,
              onRemoved: onRemoved,
            );
          },
        ),
      ),
    );
  }
}

class _CartItemCardContent extends StatelessWidget {
  const _CartItemCardContent({
    required this.item,
    required this.cubit,
    this.onRemoved,
  });

  final CartItem item;
  final CartActionCubit cubit;
  final Function(int)? onRemoved;

  @override
  Widget build(BuildContext context) {
    final price =
        item.itemProductPriceAfterDiscount ??
        double.tryParse(item.itemProductPrice ?? '0') ??
        0.0;

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
          // ── Book cover ──────────────────────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.itemProductImage ?? '',
              width: 90,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, _) => Container(
                width: 90,
                height: 120,
                decoration: BoxDecoration(
                  color: LightPalette.borderColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.book_outlined,
                  color: LightPalette.greyColor,
                  size: 32,
                ),
              ),
            ),
          ),

          const Gap(12),

          // ── Content ─────────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title row + remove button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.itemProductName ?? '',
                        style: TextStyles.subtitle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: LightPalette.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        onRemoved?.call(item.itemProductId ?? 0);
                        cubit.removeFromCart(item.itemProductId ?? 0);
                      },
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: LightPalette.greyColor,
                      ),
                    ),
                  ],
                ),

                const Gap(4),

                // Price
                Text(
                  '\$$price',
                  style: TextStyles.body.copyWith(
                    color: LightPalette.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Gap(12),

                // Quantity stepper
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _StepperButton(
                      icon: Icons.remove,
                      onTap: () {
                        if (cubit.quantity == 1) {
                          onRemoved?.call(item.itemProductId ?? 0);
                          cubit.removeFromCart(item.itemProductId ?? 0);
                        } else {
                          cubit.updateMinus(item.itemProductId ?? 0);
                        }
                      },
                    ),
                    SizedBox(
                      width: 36,
                      child: Text(
                        cubit.quantity.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyles.subtitle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: LightPalette.textPrimary,
                        ),
                      ),
                    ),
                    _StepperButton(
                      icon: Icons.add,
                      onTap: cubit.quantity < cubit.stock
                          ? () => cubit.updatePlus(item.itemProductId ?? 0)
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: enabled ? LightPalette.primaryColor : LightPalette.borderColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? LightPalette.whiteColor : LightPalette.greyColor,
        ),
      ),
    );
  }
}
