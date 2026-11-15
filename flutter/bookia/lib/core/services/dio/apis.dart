class Apis {
  static const String baseUrl = 'https://codingarabic.eraapro.com/api';

  // Auth
  static const String register = '/register';
  static const String login = '/login';

  // home
  static const String sliders = '/sliders';
  static const String bestSellerBooks = '/products-bestseller';

  // details
  static String productDetails(int id) => '/products/$id';

  // search
  static const String productsSearch = '/products-search';

  // wishlist
  static const String wishlist = '/wishlist';
  static const String removeFromWishlist = '/remove-from-wishlist';
  static const String addToWishlist = '/add-to-wishlist';

  //cart
  static const String cart = '/cart';
  static const String removeFromCart = '/remove-from-cart';
  static const String addToCart = '/add-to-cart';
  static const String updateCart = '/update-cart';

  //order
  static const String checkout = '/checkout';
  static const String placeOrder = '/place-order';
}
