import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
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
    GetPage(name: Routenames.SignUpScreen, page: () => Signupscreen())
  ];
}
