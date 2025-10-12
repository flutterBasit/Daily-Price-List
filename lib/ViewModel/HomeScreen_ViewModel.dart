import 'package:daily_price_list/Model/categoeyImages.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:daily_price_list/Resources/Utilities/NetworkUtils.dart';

import 'package:daily_price_list/Services/Api_services.dart';
import 'package:daily_price_list/View/Home_Screens/Order_Screens/OrderDeclined.dart';
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
  var isLoading = true.obs;
//for Checking Internet error
  var hasInternetError = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchAll();
    fetchCategories();
  }

  @override
  void onClose() {
    shopTextController.clear();
    exploreTextController.clear();
    super.onClose();
  }

  //function for the init
  Future<void> fetchAll() async {
    try {
      await Future.wait([
        fetchPromoBanner(),
        fetchExclusiveProducts(),
        fetchBestSellingProducts(),
        fetchGroceriesProducts(),
        fetchMeatProducts(),
        fetchAllProducts()
      ]);
    } finally {
      isLoading.value = false;
    }
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

  //Seaech Functionality -------------------------------- In ShopScreen-------------
  var searhQuery = ''.obs;
  var isSearching = false.obs;
  var searchResult = <dynamic>[].obs;
  final shopTextController = TextEditingController();

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
    // final allProduicts = [...products, ...products2, ...Groceries, ...Meat];

    //making the uniqueProductMap based on the id of the item so that the item is not duplicated
    // final uniqueProductMap = <int, Map<String, dynamic>>{};
    //search through entire API
    searchResult.value = allproduct2.where((product) {
      final title = product['title']?.toString().toLowerCase() ?? '';
      return title.contains(query.toLowerCase());
    }).toList();

    //ensure that search results are availabe for cart operations
    for (var product in searchResult) {
      ensureProductInAllProduct(product);
    }
  }

  //helper function for ensuring the product exists in allProduct
  void ensureProductInAllProduct(Map<String, dynamic> product) {
    final productId = product['id'];
    if (!allProducts.any((p) => p['id'] == productId)) {
      allProducts.add(Map<String, dynamic>.from(product));
    }
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

  // void addProductUnique(List<Map<String, dynamic>> newProducts) {
  //   for (var product in newProducts) {
  //     if (!allProducts.any((p) => p['id'] == product['id'])) {
  //       allProducts.add(product);
  //     }
  //   }
  // }
  void addProductUnique(List<Map<String, dynamic>> newProducts) {
    for (var product in newProducts) {
      ensureProductInAllProduct(product); // ✅ always ensures safe add
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
    //find in allproducts2
    final product = allproduct2.firstWhereOrNull((p) => p['id'] == productID);
    if (product != null) {
      ensureProductInAllProduct(product);
    }
    //update cart safetly
    // if (!myCartProduct.containsKey(productID)) {
    //   myCartProduct[productID] = myCartProduct[productID]! + quantity;
    //   Get.snackbar("Cart", "Product Added to Cart!",
    //       icon: Icon(Icons.shopping_cart),
    //       snackPosition: SnackPosition.BOTTOM,
    //       duration: Duration(seconds: 2));
    // } else {
    //   Get.snackbar("Already in Cart", "Item already added to cart");
    //   myCartProduct[productID] = quantity;
    // }
    //  final currentQty = myCartProduct[productID] ?? 0;
    // myCartProduct[productID] = currentQty + quantity;
    if (myCartProduct.containsKey(productID)) {
      Get.snackbar(
        "cart",
        "Product already in cart!",
        snackPosition: SnackPosition.TOP,
      );
    } else {
      myCartProduct[productID] = quantity;
      Get.snackbar(
        "cart",
        "Product added to cart!",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    update();
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
      0.0, (sum, product) => sum + product['totalprice']);

  //---------------------EXPLORE SCREEN---------------------------------

  var category = <CategoryModel>[].obs;
//storing the names of the product through categories
  RxMap<String, String> categoryImages = <String, String>{}.obs;
  var isExploreLoading = false.obs;
  var exploreLoadedOnce = false; // ✅ keeps track

  //making the explorescreen to show the skeletonizer
  // void triggerExploreTabLoading() {
  //   isLoading.value = true;

  //   fetchCategories();
  // }
  void triggerExploreTabLoading() {
    if (!exploreLoadedOnce) {
      // ✅ only first time
      isExploreLoading.value = true;
      Future.delayed(const Duration(seconds: 2), () {
        isExploreLoading.value = false;
        exploreLoadedOnce = true; // ✅ mark as loaded
      });
    }
  }

  //function for getting the category names
  void fetchCategories() async {
    try {
      isLoading.value = true;
      final response =
          await _makeAPIcalls(() => ApiServices.get('products/categories'));
      // print('Categories API response: $response');
      category.value = CategoryModel.fromList(response);
      // print('Categories parsed: ${category.value}');
      //fetch product name for each category
      await Future.wait(
          category.value.map((cat) => fetchCategoryImage(cat.name)));
    } catch (e) {
      if (!hasInternetError.value) {
        Get.snackbar('Error', 'Failed to Fetch Groceries \n Internet Error');
      }
    } finally {
      isLoading.value = false;
    }
  }

  //fetch the first product image for each category
  Future<void> fetchCategoryImage(String categoryName) async {
    try {
      final response = await _makeAPIcalls(
          () => ApiServices.get('products/category/$categoryName?limit=1'));

      if (response['products'] != null && response['products'].isNotEmpty) {
        final firstProduct = response['products'][0];
        if (firstProduct['images'] != null &&
            firstProduct['images'].isNotEmpty) {
          categoryImages[categoryName] = firstProduct['images'][0];
        }
      }
    } catch (e) {
      print('Error fetching image for $categoryName: $e');
      // categoryImages[categoryName] = 'https://via.placeholder.com/150';
      categoryImages[categoryName] =
          'https://placehold.co/150x150?text=No+Image';
    }
  }

  String getCategoryImage(String categoryName) {
    // Check if we have the image in our map
    if (categoryImages.containsKey(categoryName)) {
      return categoryImages[categoryName]!;
    }

    // If not, try to find it in existing products as fallback
    try {
      final allProductsLists = [products, products2, Groceries, Meat, product];

      for (var productList in allProductsLists) {
        if (productList.isNotEmpty) {
          for (var prod in productList) {
            if (prod != null &&
                prod['category'] != null &&
                prod['category'].toString().toLowerCase() ==
                    categoryName.toLowerCase() &&
                prod['images'] != null &&
                prod['images'] is List &&
                prod['images'].isNotEmpty) {
              return prod['images'][0];
            }
          }
        }
      }
    } catch (e) {
      print('Error in getCategoryImage: $e');
    }

    // return 'https://via.placeholder.com/150';
    return 'https://placehold.co/150x150?text=No+Image';
  }

  var product = [].obs;
  var allproduct2 = [].obs;
  var productByCategory = <dynamic>[].obs;
  //getting the product by category
  Future<void> fetchProductsByCategory(String category) async {
    try {
      isLoading.value = true;

      final response = await _makeAPIcalls(
          () => ApiServices.get('products/category/$category'));

      productByCategory.value = response['products'];
      // add them to global list (avoid duplicates)
      for (var p in response['products']) {
        if (!allproduct2.any((ap) => ap['id'] == p['id'])) {
          allproduct2.add(p);
        }
        // 🔥 Ensure they’re available for cart
        ensureProductInAllProduct(p);
      }
    } catch (e) {
      if (!hasInternetError.value) {
        Get.snackbar('Error', 'Failed to Fetch Groceries \n Internet Error');
      }
    } finally {
      isLoading.value = false;
    }
  }

//  var allproduct2 = [].obs;
  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;

      final response = await _makeAPIcalls(() => ApiServices.get('products'));
      allproduct2.value = response['products'] ?? [];

      // Ensure all fetched products are in allProducts for cart operations
      for (var product in allproduct2) {
        ensureProductInAllProduct(product);
      }

      print("DEBUG: Loaded all products = ${allproduct2.length}");
    } catch (e) {
      if (!hasInternetError.value) {
        Get.snackbar('Error', 'Failed to Fetch All Products \n Internet Error');
      }
    } finally {
      isLoading.value = false;
    }
  }

  //making the Search functionality----for the Explore screen
  var searchQuery2 = ''.obs;
  var searchResult2 = [].obs;
  final exploreTextController = TextEditingController();
  var isSearching2 = false.obs;
  Future<void> search(String query) async {
    searchQuery2.value = query.trim();

    if (searchQuery2.value.isEmpty) {
      isSearching2.value = false;
      searchResult2.clear();
      return;
    }

    try {
      isLoading.value = true;
      isSearching2.value = true;
      searchResult2.clear();

      // Search only in categories - ONLY BY CATEGORY NAME
      final categoryResults = category
          .where((cat) =>
              cat.name.toLowerCase().contains(searchQuery2.value.toLowerCase()))
          .toList();

      // Format results for display with proper structure
      searchResult2.value = categoryResults
          .map((cat) => {
                'type': 'category',
                'data': cat,
                'name': cat.name,
                'image': getCategoryImage(cat.name)
              })
          .toList();
    } catch (e) {
      if (!hasInternetError.value) {
        Get.snackbar('Error', 'Failed to Search Categories \n Internet Error');
      }
    } finally {
      isLoading.value = false;
    }
  }

  //clearing the seach
  void clearSearch2() {
    searchQuery2.value = '';
    isSearching.value = false;
    searchResult2.clear();
  }

  //---------------------------CHECKOUT FUNCTIONS---------------------------------
  final RxBool showDeliveryDetails = false.obs;
  //Delivery Method
  var selectedDeliveryMethod = Rxn<DeliveryMethod>();

  double get deliveryCost {
    switch (selectedDeliveryMethod.value) {
      case DeliveryMethod.standard:
        return 3.99;
      case DeliveryMethod.express:
        return 7.99;
      case DeliveryMethod.sameDay:
        return 12.99;
      case DeliveryMethod.pickup:
        return 0.0;
      default:
        return 0.0;
    }
  }

  //get method for showing the delivery method when selected

  String get selectDeliveryText {
    switch (selectedDeliveryMethod.value) {
      case DeliveryMethod.standard:
        return "Standard Delivery";
      case DeliveryMethod.express:
        return "Express Delivery";
      case DeliveryMethod.sameDay:
        return "Same-Day Delivery";
      case DeliveryMethod.pickup:
        return "PickUp";
      default:
        return "Select Method";
    }
  }

  //making the deliverymehtod change
  void updateDeliveryMethod(DeliveryMethod method) {
    selectedDeliveryMethod.value = method;
  }

  //total grand price after adding it with the delivery cost
  // double get totalWithDelivery => totalCartPrice + deliveryCost;
  double get totalWithDelivery {
    double subtotal = totalCartPrice + deliveryCost;
    return (subtotal - discount.value).clamp(
        0.0,
        double
            .infinity); //clamp used to set the value between the limit defined
  }

  //payment
  final RxBool showPaymentDetails = false.obs;
  final Rxn<PaymentMethod> selectedPaymentMethod = Rxn<PaymentMethod>();
  //getter
  String get selectPayment {
    switch (selectedPaymentMethod.value) {
      case PaymentMethod.debitCard:
        return "Debit Card";
      case PaymentMethod.EasyPaisa:
        return "Pay with EasyPaisa";
      case PaymentMethod.JazzCash:
        return "Pay with JazzCash";
      case PaymentMethod.COD:
        return "Cash on Delivery";
      default:
        return "Select Method";
    }
  }

  //method to update the selected paymemt method
  void updatePaymentMethod(PaymentMethod method) {
    selectedPaymentMethod.value = method;
  }

  //Promo Code
  final RxBool showPromoCodeDetails = false.obs;
  final PromoCodeController = TextEditingController();

  final RxString promoMessage = "".obs;
  final RxBool isPromoValid = false.obs;
  final RxDouble discount = 0.0.obs;

  //function for the prmocode is it valid or not
  //apply promocode
  void applyPromoCode() {
    String code = PromoCodeController.text.trim();

    if (code == "DISCOUNT10") {
      isPromoValid.value = true;
      promoMessage.value = "Promo Applied! 10% Discount Added.";
      //Reduce Cart total price by 10 percent
      discount.value = totalCartPrice * 0.9;
      //go to the totalCartprice and update the code for the price with and without discount
    } else {
      isPromoValid.value = false;
      promoMessage.value = "Invalid Promo Code";
      discount.value = 0.0;
    }
  }

  //showing the total
  final RxBool showTotalPriceDetails = false.obs;

  void Reset_CheckOut() {
    //reset
    selectedDeliveryMethod.value = null;
    selectedPaymentMethod.value = null;

    //clear promo
    PromoCodeController.clear();
    promoMessage.value = '';
    isPromoValid.value = false;
    discount.value = 0.0;

    //collopse the sections in checkout
    showDeliveryDetails.value = false;
    showPaymentDetails.value = false;
    showPromoCodeDetails.value = false;
    showTotalPriceDetails.value = false;
  }

//------------------ORDER CONFIRMATION SCREEN---------------

  //function to navigate if the order is accepted or rejected
  void proceedToOrder(BuildContext context) async {
    //showing the loading dilague
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
              child: CircularProgressIndicator(
                color: ColorsConstants.greenColor,
              ),
            ));

    //adding delay
    await Future.delayed(const Duration(seconds: 3));

    //clsoe the loading indicator
    if (!context.mounted) return;
    Navigator.of(context).pop();

    if (selectedDeliveryMethod.value != null &&
        selectedPaymentMethod.value != null) {
      Get.back();

      if (cartProductDetails.isEmpty) {
        Get.snackbar("Cart Empty!", "Please add items to your cart first");
        return;
      }

      final order = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'items': List<Map<dynamic, dynamic>>.from(cartProductDetails),
        'total': totalWithDelivery,
        'deliveryMethod':
            selectedDeliveryMethod.value?.toString().split('.').last,
        'paymentMethod':
            selectedPaymentMethod.value?.toString().split('.').last,
        'date': DateFormat('yyyy-MM-dd - kk:mn').format(DateTime.now())
      };

      //adding the above order to the RxList
      orderHistory.add(order);
      //adding the expansion tracker for each order
      orderExpanded.add(false);

      //clearing the cart and checkout
      clearCart();
      Reset_CheckOut();
      //navigate
      Get.toNamed(Routenames.OrderAcceptedScreen);

      Get.snackbar("Order Placed", "You Order has been added to order history",
          icon: const Icon(
            Icons.check_circle,
            color: ColorsConstants.greenColor,
          ),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1));
    } else {
      Get.back();
      if (!context.mounted) return;
      showOrderDeclinedScreen(context);
    }
  }

  //---------------------------ACCOUNT SCREEN-----------------------------
  //ORDERS
  final RxBool ShowOrderDetails = false.obs;

  RxList<Map<String, dynamic>> orderHistory = <Map<String, dynamic>>[].obs;

  RxList<bool> orderExpanded = <bool>[].obs;
  //the above two RxList are used in the checkout function of procedetoorder

  //MY DETAILS
  final RxBool showMyDetails = false.obs;
}

enum DeliveryMethod { standard, express, sameDay, pickup }

enum PaymentMethod { debitCard, EasyPaisa, JazzCash, COD }
