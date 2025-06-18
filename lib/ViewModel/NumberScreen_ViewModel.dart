import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberScreen_Controller extends GetxController {
  //making the phoneNumber and shownextbutton observable
  final phoneNumber = ''.obs;
  final otp = ''.obs;
  final enteredOpt = ''.obs;
  final showNextButton = false.obs;
  final keyboardVisible = false.obs;

  //function to check if the field is empty or not
  void updatePhoneNumber(String value) {
    phoneNumber.value = value;
    showNextButton.value = value.length == 10;
  }

  //function for the fake otp
  void geerateFakeOtp() {
    otp.value = '1234';
    Get.snackbar(
      'Fake OTP sent...',
      'Plese use this otp to register ${otp.value}',
      backgroundColor: ColorsConstants.greenColor,
      colorText: Colors.white,
    );
  }

  void updateEnteredOTP(String value) {
    enteredOpt.value = value;
    showNextButton.value = value.length == 4;
  }

  bool verfitynumber() {
    return enteredOpt.value == otp.value;
  }

  //function for the button
  void proceedToNext() {}
}
