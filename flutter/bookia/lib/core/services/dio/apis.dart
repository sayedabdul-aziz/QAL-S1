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
}
