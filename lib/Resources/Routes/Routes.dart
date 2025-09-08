import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:daily_price_list/View/Home_Screens/CartScreen.dart';
import 'package:daily_price_list/View/Home_Screens/ExploreScreen.dart';
import 'package:daily_price_list/View/Home_Screens/HomeScreen.dart';
import 'package:daily_price_list/View/Home_Screens/ProductScreen.dart';
import 'package:daily_price_list/View/Home_Screens/ShopScreen.dart';
import 'package:daily_price_list/View/Home_Screens/ShopScreen2.dart';
import 'package:daily_price_list/View/LogInScreen.dart';
import 'package:daily_price_list/View/NumberScreen.dart';
import 'package:daily_price_list/View/OnBoardingScreen.dart';
import 'package:daily_price_list/View/SelectLocationScreen.dart';
import 'package:daily_price_list/View/SignUpScreen.dart';
import 'package:daily_price_list/View/SigninScreen.dart';
import 'package:daily_price_list/View/SplashScreen.dart';
import 'package:daily_price_list/View/VerficationScreen.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage> routes = [
    GetPage(name: Routenames.splashScreen, page: () => Splashscreen()),
    GetPage(name: Routenames.onBoardingScreen, page: () => OnBoardingScreen()),
    GetPage(name: Routenames.signinScreen, page: () => Signinscreen()),
    GetPage(name: Routenames.numberScreen, page: () => Numberscreen()),
    GetPage(
        name: Routenames.verficationScreen, page: () => VerficationScreen()),
    GetPage(
        name: Routenames.selectlocationScreen,
        page: () => SelectlocationScreen()),
    GetPage(name: Routenames.logInScreen, page: () => Loginscreen()),
    GetPage(name: Routenames.SignUpScreen, page: () => Signupscreen()),
    GetPage(name: Routenames.HomeScreen, page: () => HomeScreen()),
    GetPage(name: Routenames.ShopScreen, page: () => Shopscreen()),
    GetPage(name: Routenames.ShopScreen2, page: () => Shopscreen2()),
    GetPage(name: Routenames.CartScreen, page: () => Cartscreen()),
    GetPage(name: Routenames.ExploreScreen, page: () => Explorescreen()),
    GetPage(
        name: Routenames.ProductScreen,
        page: () {
          final categoryName = Get.arguments as String? ?? '';
          return Productscreen(CategoryName: categoryName);
        })
  ];
}
