import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/cart/presentation/cart_action/cubit/cart_action_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartAction extends StatelessWidget {
  const CartAction({
    super.key,
    required this.productId,
    this.onRemoved,
    required this.price,
  });
  final int productId;
  final double price;
  final Function(int)? onRemoved;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartActionCubit(),
      child: BlocBuilder<CartActionCubit, CartActionState>(
        builder: (context, state) {
          bool isInCart = context.read<CartActionCubit>().checkIfProductInCart(
            productId,
          );
          return isInCart ? updateQuantityUi(context) : addToCartCta(context);
        },
      ),
    );
  }

  Widget addToCartCta(BuildContext context) {
    var cubit = context.read<CartActionCubit>();

    return Expanded(
      child: MainButton(
        text: 'Add To Cart',
        bgColor: LightPalette.textPrimary,
        onPressed: () {
          cubit.addToCart(productId);
        },
      ),
    );
  }

  Widget updateQuantityUi(BuildContext context) {
    return BlocBuilder<CartActionCubit, CartActionState>(
      builder: (context, state) {
        var cubit = context.read<CartActionCubit>();
        return Column(
          children: [
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'remove',
                  mini: true,
                  elevation: 0,
                  backgroundColor: LightPalette.primaryColor,
                  child: const Icon(
                    Icons.remove,
                    color: LightPalette.whiteColor,
                  ),
                  onPressed: () {
                    if (cubit.quantity == 1) {
                      cubit.removeFromCart(productId);
                      onRemoved?.call(productId);
                    } else {
                      cubit.updateMinus(productId);
                    }
                  },
                ),
                SizedBox(
                  width: 35,
                  child: Text(
                    cubit.quantity.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyles.title1,
                  ),
                ),
                FloatingActionButton(
                  heroTag: 'add',
                  mini: true,
                  elevation: 0,
                  backgroundColor: LightPalette.primaryColor,
                  child: const Icon(Icons.add, color: LightPalette.whiteColor),
                  onPressed: () {
                    cubit.updatePlus(productId);
                  },
                ),
              ],
            ),
            Text(
              'Total \$${(price * cubit.quantity).ceil()}',
              style: TextStyles.body,
            ),
          ],
        );
      },
    );
  }
}
