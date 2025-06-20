import 'package:get/get.dart';

class HomeScreen_ViewController extends GetxController {
  RxInt selectedIndex = 0.obs;

  //function for the Indexing
  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}
