class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartCheckoutLoadingState extends CartState {}

class CartSuccessState extends CartState {}

class CartCheckoutSuccessState extends CartState {}

class CartErrorState extends CartState {
  final String message;
  CartErrorState({required this.message});
}
