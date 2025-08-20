import 'package:daily_price_list/Resources/Utilities/NetworkUtils.dart';

import 'package:daily_price_list/Services/Api_services.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen_ViewController extends GetxController {
  RxInt selectedIndex = 0.obs;

  //function for the Indexing the bottom navigation bar
  void updateIndex(int index) {
    selectedIndex.value = index;
  }

//---------------------SHOP SCREEN--------------------------------------------------
  //making the banner , using the fake API , the api_service class to use the api and then
  // use it in the banner as we dont have banner data so we create it using the API we have
  // from the discount variable response in the API

  var banners = <Map<String, dynamic>>[].obs;
  //for loading
  var isLoading = false.obs;
//for Checking Internet error
  var hasInternetError = false.obs;
  @override
  void onInit() {
    //put the banner function
    fetchPromoBanner();
    fetchExclusiveProducts();
    fetchBestSellingProducts();
    fetchGroceriesProducts();
    fetchMeatProducts();
    super.onInit();
  }

//function for the base API calls for tracking the Internet issue
  Future<dynamic> _makeAPIcalls(Future<dynamic> Function() apiCall) async {
    try {
      hasInternetError(false);
      return await apiCall();
    } on DioException catch (e) {
      if (Networkutils.isNetworkError(e)) {
        hasInternetError(true);
      }
      rethrow;
    } catch (e) {
      if (Networkutils.isNetworkError(e)) {
        hasInternetError(true);
      }
      rethrow;
    }
  }

  //Seaech Functionality --------------------------------
  var searhQuery = ''.obs;
  var isSearching = false.obs;
  var searchResult = <dynamic>[].obs;

  //adding search method
  void searchProduct(String query) {
    searhQuery.value = query;

    if (query.isEmpty) {
      isSearching.value = false;
      searchResult.clear();
      return;
    }
    //if isSearching is true
    isSearching.value = true;
    //combining all products list for searching
    final allProduicts = [...products, ...products2, ...Groceries, ...Meat];

    //Search filter products based on search query
    searchResult.value = allProduicts.where((product) {
      final title = product['title']?.toString().toLowerCase() ?? '';
      final tags = product['tags']?.toString().toLowerCase() ?? '';
      final description =
          product['description']?.toString().toLowerCase() ?? '';

      return title.contains(query.toLowerCase()) ||
          tags.contains(query.toLowerCase()) ||
          description.contains(query.toLowerCase());
    }).toList();
  }

  //clear search
  void clearSearch() {
    searhQuery.value = '';
    isSearching.value = false;
    searchResult.clear();
  }

// API fetch for the -------------------banner------------
  Future<void> fetchPromoBanner() async {
    try {
      isLoading(true);
      final response = await _makeAPIcalls(() => ApiServices.get('products'));

      List allProducts = response['products'];
      //showing the first 10 products thumbnail as promos
      banners.value = allProducts
          .where((item) => item['discountPercentage'] > 10)
          .take(5)
          .toList()
          .cast<Map<String, dynamic>>();
    } catch (e) {
      if (!hasInternetError.value) {
        Get.snackbar('Error', 'Could not load promotional item');
      }
    } finally {
      isLoading(false);
    }
  }

  //for the banner dots
  RxInt currentBannerIndex = 0.obs;

  // API fetch for the ------------------------Exclusive offers------------
  // for products
  var products = <Map<String, dynamic>>[].obs;

  // function for fetching the API for the exclusive offers
  Future<void> fetchExclusiveProducts() async {
    try {
      isLoading.value = true;
      final response = await _makeAPIcalls(
          () => ApiServices.get('products/category/groceries'));
      products.value = List<Map<String, dynamic>>.from(response['products']
          .where((p) => (p['tags'] as List).contains('fruits')));
//for adding favourite
      addProductUnique(products);
    } catch (e) {
      if (!hasInternetError.value) {
        Get.snackbar('Error', 'Failed to Fetch Products \n Internet Error');
      }
    } finally {
      isLoading.value = false;
    }
  }

  // API fetch for the--------------------- Best Selling----------------
  // for products
  var products2 = <Map<String, dynamic>>[].obs;

  // function for fetching the API for the exclusive offers
  Future<void> fetchBestSellingProducts() async {
    try {
      isLoading.value = true;
      final response = await _makeAPIcalls(
          () => ApiServices.get('products/category/groceries'));
      products2.value = List<Map<String, dynamic>>.from(response['products']
          .where((p) => (p['tags'] as List).contains('vegetables')));
//for adding favourite
      addProductUnique(products2);
    } catch (e) {
      if (!hasInternetError.value) {
        Get.snackbar('Error', 'Failed to Fetch Products \n Internet Error');
      }
    } finally {
      isLoading.value = false;
    }
  }

  //------   Api fetch for the -------------------groceries----------

  var Groceries = <Map<String, dynamic>>[].obs;

  Future<void> fetchGroceriesProducts() async {
    try {
      isLoading.value = true;
      final response = await _makeAPIcalls(
          () => ApiServices.get('products/category/groceries'));
      Groceries.value = List<Map<String, dynamic>>.from(response['products']);

//for adding favourite
      addProductUnique(Groceries);
    } catch (e) {
      if (!hasInternetError.value) {
        Get.snackbar('Error', 'Failed to Fetch Groceries \n Internet Error');
      }
    } finally {
      isLoading.value = false;
    }
  }

  //------   Api fetch for the -------------------Meat----------

  var Meat = <Map<String, dynamic>>[].obs;

  Future<void> fetchMeatProducts() async {
    try {
      isLoading.value = true;
      final response = await _makeAPIcalls(
          () => ApiServices.get('products/category/groceries'));
      Meat.value = List<Map<String, dynamic>>.from(response['products']
          .where((p) => (p['tags'] as List).contains('meat')));

      //for adding favourite
      addProductUnique(Meat);
    } catch (e) {
      if (!hasInternetError.value) {
        Get.snackbar('Error', 'Failed to Fetch Groceries \n Internet Error');
      }
    } finally {
      isLoading.value = false;
    }
  }

  //-----------------------SHOP SCREEN-2--------------------------------------------------

  RxInt count = 1.obs;

  // function for increment
  void increment() {
    count.value++;
  }

  // function for decrement
  void decrement() {
    if (count.value > 1) {
      count.value--;
    }
  }

  // rx variable for the making the Product Details and other expandable
  final RxBool showDetails = false.obs;
  final RxBool showCategoryDetails = false.obs;
  final RxBool showReviewDetails = false.obs;

//making the function for the share button

  Future<void> shareProduct(Map<String, dynamic> product) async {
    try {
      final imageUrl = product['images'][0];
      final fileName = 'product_name.png';
      final temDir = await getTemporaryDirectory();
      final filePath = '${temDir.path}/$fileName';

      //Download the image using Dio
      await Dio().download(imageUrl, filePath);

      //get the current date and time
      final now = DateTime.now();
      final formattedDate = DateFormat('EEEE, MMM d, yyyy').format(now);

      //create the message
      final String message = '''
     🛍️ ${product['title']}
📅 Date: $formattedDate
💵 Price: \$${product['price'].toStringAsFixed(2)}

Add your notes here:
 ''';

      //  share using shareplus

      await SharePlus.instance.share(ShareParams(
        files: [XFile(filePath)],
        text: message,
        subject: "Check out this product!",
      ));

      // await SharePlus.instance.share(files: [XFile(filePath)],
      //     text: message, subject: 'Check out todays price!');
    } catch (e) {
      Get.snackbar("Share Failed", "Unable to share product : ${e.toString()}");
    }
  }

  //making function and obervable for comment
  //how a user can add comment
  var showReviewDetail = false.obs;

  //
  // RxMap<String,dynamic> commentTextMap = <String,String>{}

  //simulated in memory review map : ProductID => List of Reviews
  RxMap<String, List<Map<String, dynamic>>> reviewMap =
      <String, List<Map<String, dynamic>>>{}.obs;

  //star rating and comment bond to the input field
  RxInt selectedRating = 0.obs;
  RxString commentText = ''.obs;

  //function for add the comment
  void addReview(String ProductId, String name, String comment, int rating) {
    final review = {'reviewName': name, 'comment': comment, 'rating': rating};

    if (!reviewMap.containsKey(ProductId)) {
      reviewMap[ProductId] = [];
    }

    reviewMap[ProductId]!.add(review);
    selectedRating.value = 0;
    commentText.value = '';
  }

//getting the reviews
  List<Map<String, dynamic>> getReviews(
      String productId, List<Map<String, dynamic>> productApiReviews) {
    final additional = reviewMap[productId] ?? [];
    return [...productApiReviews, ...additional]; //... is the spread operator
    //  insert all elements from a collection (like a List) into another list.
  }

//----------------------FAVOURITE SCREEN---------------------
  //---Functionallity for the favourite
  var favouriteProduct = <int>[].obs;

//toggling
  void toggleFavourite(int productId) {
    if (favouriteProduct.contains(productId)) {
      favouriteProduct.remove(productId);
    } else {
      favouriteProduct.add(productId);
      Get.snackbar('Favourite', 'Product Added to Favourites!',
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2));
    }
  }

  bool isFavourite(int productId) {
    return favouriteProduct.contains(productId);
  }

  var allProducts = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get favouriteProductDetails => allProducts
      .where((product) => favouriteProduct.contains(product['id']))
      .toList();
//helper for the favourite so that it should not be duplicated

  void addProductUnique(List<Map<String, dynamic>> newProducts) {
    for (var product in newProducts) {
      if (!allProducts.any((p) => p['id'] == product['id'])) {
        allProducts.add(product);
      }
    }
  }

  //function for the items in favourite to be added to cart
  void addAllFavouriteToCart() {
    for (var productId in favouriteProduct) {
      addToCart(productId);
    }
  }

  //-------------------CART SCREEN-----------------------------
  // var myCartProduct = <int>[].obs;
  var myCartProduct = <int, int>{}.obs;

  void addToCart(int productID, {int quantity = 1}) {
    if (!myCartProduct.containsKey(productID)) {
      myCartProduct[productID] = quantity;
      Get.snackbar("Cart", "Product Added to Cart!",
          icon: Icon(Icons.shopping_cart),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2));
    } else {
      Get.snackbar("Already in Cart", "Item already added to cart");
    }
  }

//function for increment with the price and quantity management

  void increaseQuantity(int productId) {
    try {
      final product = allProducts.firstWhere((p) => p['id'] == productId);
      int stock = product['stock'] ?? 0;
      int currentQty = myCartProduct[productId] ?? 0;

      if (currentQty < stock) {
        myCartProduct[productId] = currentQty + 1;
      } else {
        Get.snackbar("Stock Limit!", "No more items in stock");
      }
    } catch (e) {
      Get.snackbar("Error", "Product not found");
    }
  }

  void decreaseQuantity(int productId) {
    int currentQty = myCartProduct[productId] ?? 0;

    if (currentQty > 1) {
      myCartProduct[productId] = currentQty - 1;
    } else if (currentQty == 1) {
      myCartProduct.remove(productId);
    } else {
      // Do nothing if 0
    }
  }

//to get the cart products with quantity

  List<Map<String, dynamic>> get cartProductDetails {
    return allProducts
        .where((product) => myCartProduct.containsKey(product['id']))
        .map((product) {
      return {
        ...product,
        'quantity': myCartProduct[product['id']],
        'totalprice': myCartProduct[product['id']]! * product['price']
      };
    }).toList();
  }

//clearing all the cart
  void clearCart() => myCartProduct.clear();
//remove the item from cart

  void removeFromCart(int productID) {
    myCartProduct.remove(productID);
  }

  //total price

  double get totalCartPrice => cartProductDetails.fold(
      0.0, (sum, product) => sum + product['total price']);
}
