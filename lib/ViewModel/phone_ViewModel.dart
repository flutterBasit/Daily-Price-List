import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:get/get.dart';

class phoneController extends GetxController {
  Rx<Country> selectedCountry =
      CountryPickerUtils.getCountryByIsoCode('PK').obs;

  RxString phoneNumber = ''.obs;

  void updateCountry(Country country) {
    selectedCountry.value = country;
    print('Selected Country : ${country.name} (${country.isoCode})');
  }

  // void updatePhoneNumber(String number) {
  //   phoneNumber.value = number;
  // }

  // String get fullPhoneNumber {
  //   return '+${selectedCountry.value.phoneCode}${phoneNumber.value}';
  // }
}
