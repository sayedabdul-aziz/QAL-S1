import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/input/custom_text_field.dart';
import 'package:bookia/components/main_app_bar.dart';
import 'package:bookia/core/constants/app_design.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/order/presentation/place_order/cubit/place_order_cubit.dart';
import 'package:bookia/features/order/presentation/place_order/cubit/place_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key, required this.total});
  final String total;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<PlaceOrderCubit>();
    return BlocListener<PlaceOrderCubit, PlaceOrderState>(
      listener: (context, state) {
        // if (state is AuthSuccessState) {
        //   pushToBase(context, RouteNames.main);
        // } else if (state is AuthErrorState) {
        //   pop(context);
        //   showMyToast(context, state.error);
        // } else if (state is AuthLoadingState) {
        //   showLoadingDialog(context);
        // }
      },
      child: Scaffold(
        appBar: MainAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(AppDesign.CONTENT_PADDING),
          child: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Place Your Order', style: TextStyles.headline1),
                  Text(
                    'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                    style: TextStyles.body.copyWith(
                      color: LightPalette.greyColor,
                    ),
                  ),
                  const Gap(32),
                  CustomTextField(
                    controller: cubit.nameController,
                    hintText: 'Full Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextField(
                    controller: cubit.emailController,
                    hintText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextField(
                    controller: cubit.phoneController,
                    hintText: 'Phone Number',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextField(
                    controller: cubit.addressController,
                    hintText: 'Address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextField(
                    readOnly: true,
                    controller: cubit.governorateController,
                    hintText: 'Governorate',
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        isScrollControlled: true,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.sizeOf(context).height * 0.6,
                        ),

                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(
                              AppDesign.CONTENT_PADDING,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Select Governorate',
                                      style: TextStyles.headline2,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: cubit.governorates.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          cubit
                                              .governorates[index]
                                              .governorateNameEn,
                                        ),
                                        onTap: () {
                                          cubit.governorateController.text =
                                              cubit
                                                  .governorates[index]
                                                  .governorateNameEn;
                                          cubit.governorateId =
                                              cubit.governorates[index].id;
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your governorate';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
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
                    '\$ $total',
                    style: TextStyles.title2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: LightPalette.textPrimary,
                    ),
                  ),
                ],
              ),
              const Gap(12),
              MainButton(text: 'Checkout', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
