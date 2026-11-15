part of 'cart_action_cubit.dart';

sealed class CartActionState {}

final class CartActionInitial extends CartActionState {}

final class CartActionSuccess extends CartActionState {}

final class CartActionError extends CartActionState {}
