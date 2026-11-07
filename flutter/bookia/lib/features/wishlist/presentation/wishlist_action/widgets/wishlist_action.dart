import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/features/wishlist/presentation/wishlist_action/cubit/wishlist_action_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistAction extends StatelessWidget {
  const WishlistAction({super.key, required this.productId, this.onRemoved});
  final int productId;
  final Function(int)? onRemoved;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistActionCubit(),
      child: BlocBuilder<WishlistActionCubit, WishlistActionState>(
        builder: (context, state) {
          var cubit = context.read<WishlistActionCubit>();
          bool isInWishlist = cubit.checkIfProductInWishlist(productId);
          return IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: LightPalette.whiteColor,
              shape: const CircleBorder(),
              side: const BorderSide(color: LightPalette.primaryColor),
            ),
            icon: Icon(
              isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: LightPalette.primaryColor,
            ),
            onPressed: () {
              cubit.addOrRemoveFromWishlist(productId);
              onRemoved?.call(productId);
            },
          );
        },
      ),
    );
  }
}

class WishlistSmallAction extends StatelessWidget {
  const WishlistSmallAction({super.key, required this.productId});
  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistActionCubit(),
      child: BlocBuilder<WishlistActionCubit, WishlistActionState>(
        builder: (context, state) {
          var cubit = context.read<WishlistActionCubit>();
          bool isInWishlist = cubit.checkIfProductInWishlist(productId);
          return IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: LightPalette.whiteColor,
              shape: const CircleBorder(),
            ),
            icon: Icon(
              isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: LightPalette.primaryColor,
            ),
            onPressed: () {
              cubit.addOrRemoveFromWishlist(productId);
            },
          );
        },
      ),
    );
  }
}
