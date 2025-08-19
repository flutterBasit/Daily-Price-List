import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteManager {
  static Future<String> getInitialRoutes() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final locationSelected = prefs.getBool('locationSelected') ?? false;

    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
      return Routenames.onBoardingScreen;
    } else if (!isLoggedIn) {
      return Routenames.signinScreen;
    } else if (!locationSelected) {
      return Routenames.selectlocationScreen;
    } else {
      return Routenames.HomeScreen;
    }
  }
}
