class Urls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';
  static const String signUpUrl = '$_baseUrl/auth/signup';
  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';
  static const String signInUrl = '$_baseUrl/auth/login';
  static const String homeSliderUrl = '$_baseUrl/slides';
  static String categoryListUrl(int pageNo, int count) => '$_baseUrl/categories?count=$count&page=$pageNo';

  static String productListUrl(int currentPage, int productsPerPage) =>
      '$_baseUrl/products?count=$productsPerPage&page=$currentPage';

  static String wishlistUrl(int currentPage, int productsPerPage) =>
      '$_baseUrl/wishlist?count=$productsPerPage&page=$currentPage';

  static String productDetailsUrl(String productId) => '$_baseUrl/products/id/$productId';

  static const String addToCartUrl = '$_baseUrl/cart';
  static const String cartListUrl = '$_baseUrl/cart';

  static String reviewListUrl(String productId) => '$_baseUrl/reviews?product=$productId';
  static const String createReviewUrl = '$_baseUrl/review';

  static const String addToWishlistUrl = '$_baseUrl/wishlist';
  static String removeFromWishlistUrl(String wishlistItemId) => '$_baseUrl/wishlist/$wishlistItemId';

  static String deleteCartItemUrl(String cartItemId) => '$_baseUrl/cart/$cartItemId';
}