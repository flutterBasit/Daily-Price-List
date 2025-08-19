import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:get/get.dart';

class phoneAuthController extends GetxController {
  Rx<Country> selectedCountry =
      CountryPickerUtils.getCountryByIsoCode('PK').obs;

  RxString phoneNumber = ''.obs;
  RxBool showNextButton = false.obs;

  void updateCountry(Country country) {
    selectedCountry.value = country;
    print('Selected Country : ${country.name} (${country.isoCode})');
  }

  void updatePhoneNumber(String number) {
    phoneNumber.value = number;
    //Show next Button only if number is not empty
    showNextButton.value = number.trim().isNotEmpty;
  }

  String get fullPhoneNumber {
    return '+${selectedCountry.value.phoneCode}${phoneNumber.value}';
  }
}
