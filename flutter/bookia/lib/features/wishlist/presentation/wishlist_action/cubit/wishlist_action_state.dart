part of 'wishlist_action_cubit.dart';

sealed class WishlistActionState {}

final class WishlistActionInitial extends WishlistActionState {}

final class WishlistActionSuccess extends WishlistActionState {}

final class WishlistActionError extends WishlistActionState {}
