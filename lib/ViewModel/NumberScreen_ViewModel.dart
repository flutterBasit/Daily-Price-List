import 'package:get/get.dart';

class NumberScreen_Controller extends GetxController {
  //making the phoneNumber and shownextbutton observable
  final phoneNumber = ''.obs;
  final showNextButton = false.obs;
  final keyboardVisible = false.obs;

  //function to check if the field is empty or not
  void updatePhoneNumber(String value) {
    phoneNumber.value = value;
    showNextButton.value = value.isNotEmpty;
  }

  //function for the button
  void proceedToNext() {}
}
