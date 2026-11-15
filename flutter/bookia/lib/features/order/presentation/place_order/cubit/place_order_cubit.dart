import 'package:bookia/features/order/data/shared/governorates_data.dart';
import 'package:bookia/features/order/presentation/place_order/cubit/place_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitial());

  List<Governorate> governorates = [];

  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final governorateController = TextEditingController();

  int governorateId = 0;

  void getGovernorates() {
    for (var element in governoratesData) {
      governorates.add(Governorate.fromJson(element));
    }
    emit(PlaceOrderSuccessState());
  }

  void placeOrder() {}
}
