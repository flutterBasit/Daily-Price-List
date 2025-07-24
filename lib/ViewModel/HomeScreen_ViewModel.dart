import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Services/Api_services.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
  var isLoading = true.obs;

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

// API fetch for the -------------------banner------------
  void fetchPromoBanner() async {
    try {
      isLoading(true);
      final response = await ApiServices.get('products');

      List allProducts = response['products'];
      //showing the first 10 products thumbnail as promos
      banners.value = allProducts
          .where((item) => item['discountPercentage'] > 10)
          .take(5)
          .toList()
          .cast<Map<String, dynamic>>();
    } catch (e) {
      Get.snackbar('Error', 'Could not load promotional item');
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
  void fetchExclusiveProducts() async {
    try {
      isLoading.value = true;
      final response = await ApiServices.get('products/category/groceries');
      products.value = List<Map<String, dynamic>>.from(response['products']
          .where((p) => (p['tags'] as List).contains('fruits')));
//for adding favourite
      addProductUnique(products);
    } catch (e) {
      Get.snackbar('Error', 'Failed to Fetch Products \n Internet Error');
    } finally {
      isLoading.value = false;
    }
  }

  // API fetch for the--------------------- Best Selling----------------
  // for products
  var products2 = <Map<String, dynamic>>[].obs;

  // function for fetching the API for the exclusive offers
  void fetchBestSellingProducts() async {
    try {
      isLoading.value = true;
      final response = await ApiServices.get('products/category/groceries');
      products2.value = List<Map<String, dynamic>>.from(response['products']
          .where((p) => (p['tags'] as List).contains('vegetables')));
//for adding favourite
      addProductUnique(products2);
    } catch (e) {
      Get.snackbar('Error', 'Failed to Fetch Products \n Internet Error');
    } finally {
      isLoading.value = false;
    }
  }

  //------   Api fetch for the -------------------groceries----------

  var Groceries = <Map<String, dynamic>>[].obs;

  void fetchGroceriesProducts() async {
    try {
      isLoading.value = true;
      final response = await ApiServices.get('products/category/groceries');
      Groceries.value = List<Map<String, dynamic>>.from(response['products']);

//for adding favourite
      addProductUnique(Groceries);
    } catch (e) {
      Get.snackbar('Error', 'Failed to Fetch Groceries \n Internet Error');
    } finally {
      isLoading.value = false;
    }
  }

  //------   Api fetch for the -------------------Meat----------

  var Meat = <Map<String, dynamic>>[].obs;

  void fetchMeatProducts() async {
    try {
      isLoading.value = true;
      final response = await ApiServices.get('products/category/groceries');
      Meat.value = List<Map<String, dynamic>>.from(response['products']
          .where((p) => (p['tags'] as List).contains('meat')));

      //for adding favourite
      addProductUnique(Meat);
    } catch (e) {
      Get.snackbar('Error', 'Failed to Fetch Groceries \n Internet Error');
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

  //-------------------CART SCREEN-----------------------------
  var myCartProduct = <int>[].obs;

  //getting the product id
  void addToCart(int productID) {
    if (!myCartProduct.contains(productID)) {
      myCartProduct.add(productID);
      Get.snackbar('Cart', 'Product Added to Cart!',
          icon: Icon(
            Icons.shopping_cart,
            color: ColorsConstants.greenColor,
          ),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2));
    }
  }

  //getter function for the cart products to get
  List<Map<String, dynamic>> get cartProductDetails => allProducts
      .where((product) => myCartProduct.contains(product['id']))
      .toList();

//clearing all the cart
  void clearCart() => myCartProduct.clear();
//remove the item from cart

  void removeFromCart(int productID) {
    myCartProduct.remove(productID);
  }
}
