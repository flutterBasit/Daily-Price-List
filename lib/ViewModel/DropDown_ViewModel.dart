import 'package:daily_price_list/Model/pakLocationModel.dart';
import 'package:get/get.dart';

class DropdownController extends GetxController {
  var selectedProvine = ''.obs;
  var selectedDistrict = ''.obs;
  var selectedZone = ''.obs;

  //geting the KEYs from the model we made the pakLocationModel
  //So, pakLocationData.keys.toList() converts the Iterable of keys into a List<String>.
  // Result: ['Khyber Pakhtunkhwa', 'Punjab', ...]

  //WHY AND WHEN TO USE GET
  // get in Dart is a "getter," a special type of method that acts like a read-only property.
  // Why use it? To provide a calculated value that's derived from other data,
  //rather than storing it directly. It hides computation details and keeps data fresh.
  List<String> get provines => pakLocationData.keys.toList();

  //GETTING DISTRICTS:
  List<String> get districts {
    if (selectedProvine.isEmpty) return [];
    return pakLocationData[selectedProvine.value]!.keys.toList();
  }

  //GETTING ZONES:
  List<String> get zones {
    if (selectedProvine.value.isEmpty || selectedDistrict.value.isEmpty)
      return [];

    return pakLocationData[selectedProvine.value]![selectedDistrict.value]!;
  }

  void selectProvince(String value) {
    selectedProvine.value = value;
    selectedDistrict.value = '';
    selectedZone.value = '';
  }
}
