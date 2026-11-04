import 'package:bookia/components/shimmer/text_shimmer.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSlider extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int yourActiveIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState || state is HomeErrorState) {
          return TextShimmer(
            width: double.infinity,
            height: 180,
            borderRadius: 10,
          );
        }
        var sliders = context.read<HomeCubit>().sliders;
        if (sliders.isEmpty) {
          return SizedBox();
        }
        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: sliders.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        sliders[itemIndex].image ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
              options: CarouselOptions(
                height: 180,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    yourActiveIndex = index;
                  });
                },
              ),
            ),
            const Gap(10),
            AnimatedSmoothIndicator(
              activeIndex: yourActiveIndex,
              count: sliders.length,
              effect: ScrollingDotsEffect(
                activeDotColor: LightPalette.primaryColor,
                dotColor: Colors.grey,
                dotHeight: 10,
                dotWidth: 10,
              ),
            ),
          ],
        );
      },
    );
  }
}
