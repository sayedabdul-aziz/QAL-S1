import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/main_app_bar.dart';
import 'package:bookia/core/constants/app_design.dart';
import 'package:bookia/core/functions/toast.dart';
import 'package:bookia/core/routes/naviagtions.dart';
import 'package:bookia/core/routes/route_names.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/cart/presentation/cart/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cart/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/cart/widgets/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightPalette.background,
      appBar: MainAppBar(hasBack: false, title: 'My Cart'),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDesign.CONTENT_PADDING,
              ),
              child: CartItems(),
            ),
          ),
          _BottomBar(),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartCheckoutLoadingState) {
          showLoadingDialog(context);
        } else if (state is CartCheckoutSuccessState) {
          pop(context);
          pushTo(
            context,
            RouteNames.placeOrder,
            extra: context.read<CartCubit>().total,
          );
        } else if (state is CartErrorState) {
          pop(context);
          showMyToast(context, state.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<CartCubit>();
        final hasItems =
            state is CartSuccessState && cubit.cartItems.isNotEmpty;

        return Container(
          padding: const EdgeInsets.fromLTRB(
            AppDesign.CONTENT_PADDING,
            16,
            AppDesign.CONTENT_PADDING,
            24,
          ),
          decoration: const BoxDecoration(
            color: LightPalette.whiteColor,
            border: Border(top: BorderSide(color: LightPalette.borderColor)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyles.body.copyWith(
                      color: LightPalette.greyColor,
                    ),
                  ),
                  Text(
                    '\$ ${cubit.total}',
                    style: TextStyles.title2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: LightPalette.textPrimary,
                    ),
                  ),
                ],
              ),
              const Gap(12),
              MainButton(
                text: 'Checkout',
                onPressed: hasItems
                    ? () {
                        cubit.checkout();
                      }
                    : () {},
                bgColor: hasItems
                    ? LightPalette.primaryColor
                    : LightPalette.borderColor,
                textColor: hasItems
                    ? LightPalette.whiteColor
                    : LightPalette.greyColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
