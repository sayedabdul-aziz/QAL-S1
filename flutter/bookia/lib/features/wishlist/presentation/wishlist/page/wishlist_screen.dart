import 'package:bookia/components/main_app_bar.dart';
import 'package:bookia/core/constants/app_design.dart';
import 'package:bookia/features/wishlist/presentation/wishlist/widgets/wishlist_books.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(hasBack: false, title: 'Wishlist'),
      body: Padding(
        padding: const EdgeInsets.all(AppDesign.CONTENT_PADDING),
        child: WishlistBooks(),
      ),
    );
  }
}
