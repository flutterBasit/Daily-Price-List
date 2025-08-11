// import 'package:daily_price_list/Model/pakLocationModel.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// import 'package:get/get.dart';

// class DropdownController extends GetxController {
//   var selectedProvine = ''.obs;
//   var selectedDistrict = ''.obs;
//   var selectedZone = ''.obs;

//   //geting the KEYs from the model we made the pakLocationModel
//   //So, pakLocationData.keys.toList() converts the Iterable of keys into a List<String>.
//   // Result: ['Khyber Pakhtunkhwa', 'Punjab', ...]

//   //WHY AND WHEN TO USE GET
//   // get in Dart is a "getter," a special type of method that acts like a read-only property.
//   // Why use it? To provide a calculated value that's derived from other data,
//   //rather than storing it directly. It hides computation details and keeps data fresh.
//   List<String> get provines => pakLocationData.keys.toList();

//   //GETTING DISTRICTS:
//   List<String> get districts {
//     if (selectedProvine.isEmpty) return [];
//     return pakLocationData[selectedProvine.value]!.keys.toList();
//   }

//   //GETTING ZONES:
//   List<String> get zones {
//     if (selectedProvine.value.isEmpty || selectedDistrict.value.isEmpty)
//       return [];

//     return pakLocationData[selectedProvine.value]![selectedDistrict.value]!;
//   }

//   void selectProvince(String value) {
//     selectedProvine.value = value;
//     selectedDistrict.value = '';
//     selectedZone.value = '';
//   }

//   void selectDistrict(String value) {
//     selectedDistrict.value = value;
//     selectedZone.value = '';
//   }

//   void selectZone(String value) {
//     selectedZone.value = value;
//   }

// //AUTOMTICALLY DETECTING AND SETTTING LOCATION

//   Future<void> detectAndSetLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //if service is disable then show the snackbar that the location is closed
//     if (!serviceEnabled) {
//       Get.snackbar(
//         "Location Disabled",
//         "Please enable location services",
//         mainButton: TextButton(
//             onPressed: () {
//               Geolocator.openLocationSettings();
//             },
//             child: Text("Open Settings")),
//       );
//       return;
//     }
// //taking location permission
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         Get.snackbar("Permission Denied", "Location permission is required");
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       Get.snackbar("Permission Blocked", "Enable location from settings",
//           mainButton: TextButton(
//               onPressed: () {
//                 Geolocator.openLocationSettings();
//               },
//               child: Text("Open App Settings")));
//       return;
//     }
// //taking the position through the geolocator
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
// //taking the placemarks as we do using the google location api the latitude or the longitude
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
// //taking the place like the placmarks then city and other through the placemarks
//     if (placemarks.isNotEmpty) {
//       final place = placemarks.first;
//       final city = place.locality?.toLowerCase().trim() ?? "";
//       final province = place.administrativeArea?.toLowerCase().trim() ?? "";
//       final zone = place.subLocality?.toLowerCase().trim() ?? "";

// //Province if the location is matched to the location in the model then store it and then display
//       final matchedProvince = pakLocationData.keys.firstWhere(
//           (p) => province.contains(p.toLowerCase()),
//           orElse: () => '');

//       if (matchedProvince.isNotEmpty) {
//         selectedProvine(matchedProvince);

//         //Destrict
//         final matchedDistrict = pakLocationData[matchedProvince]!
//             .keys
//             .firstWhere((p) => city.contains(p.toLowerCase()),
//                 orElse: () => '');

//         if (matchedDistrict.isNotEmpty) {
//           selectedDistrict(matchedDistrict);
//         }

//         //zone
//         final matchedZone = pakLocationData[matchedProvince]![matchedDistrict]!
//             .firstWhere((p) => zone.contains(p.toLowerCase()),
//                 orElse: () => '');

//         if (matchedZone.isNotEmpty) {
//           selectedZone(matchedZone);
//         }
//       }
//     }
//   }
// }

import 'package:daily_price_list/Model/pakLocationModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class DropdownController extends GetxController {
  var selectedProvine = ''.obs;
  var selectedDistrict = ''.obs;
  var selectedZone = ''.obs;

//for laoding
  var isloading = false.obs;

  final customDistricts = <String>[].obs;
  final customZones = <String>[].obs;

  List<String> get provines => [
        ...pakLocationData.keys,
        if (!pakLocationData.keys.contains(selectedProvine.value) &&
            selectedProvine.value.isNotEmpty)
          selectedProvine.value,
      ];

  List<String> get districts {
    if (selectedProvine.isEmpty) return [];
    final builtInDistricts =
        pakLocationData[selectedProvine.value]?.keys.toList() ?? [];
    return [
      ...builtInDistricts,
      if (!builtInDistricts.contains(selectedDistrict.value) &&
          selectedDistrict.value.isNotEmpty)
        selectedDistrict.value,
    ];
  }

  List<String> get zones {
    if (selectedProvine.isEmpty || selectedDistrict.isEmpty) return [];
    final builtInZones = pakLocationData[selectedProvine.value]
                ?[selectedDistrict.value]
            ?.toList() ??
        [];
    return [
      ...builtInZones,
      if (!builtInZones.contains(selectedZone.value) &&
          selectedZone.value.isNotEmpty)
        selectedZone.value,
    ];
  }

  void selectProvince(String value) {
    selectedProvine.value = value;
    selectedDistrict.value = '';
    selectedZone.value = '';
  }

  void selectDistrict(String value) {
    selectedDistrict.value = value;
    selectedZone.value = '';
  }

  void selectZone(String value) {
    selectedZone.value = value;
  }

  Future<void> detectAndSetLocation() async {
    isloading.value = true;

    final location = loc.Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        Get.snackbar("Location Required", "Please enable location services");
        return;
      }
    }

    var permission = await location.hasPermission();
    if (permission == loc.PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != loc.PermissionStatus.granted) {
        Get.snackbar("Permission Denied", "Location permission is required");
        return;
      }
    }

    final locationData = await location.getLocation();
    final latitude = locationData.latitude ?? 0.0;
    final longitude = locationData.longitude ?? 0.0;

    final placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isEmpty) return;

    final place = placemarks.first;

    // From GPS
    final detectedProvince = place.administrativeArea?.trim() ?? '';
    final detectedDistrict = place.subAdministrativeArea?.trim() ?? '';
    final detectedZone =
        place.subLocality?.trim() ?? place.locality?.trim() ?? '';

    print(
        '🧭 Detected -> Province: $detectedProvince | District: $detectedDistrict | Zone: $detectedZone');

    // --- Province ---
    final matchedProvince = pakLocationData.keys.firstWhere(
      (p) => detectedProvince.toLowerCase().contains(p.toLowerCase()),
      orElse: () => '',
    );
    final selectedProvinceValue =
        matchedProvince.isNotEmpty ? matchedProvince : detectedProvince;
    selectedProvine(selectedProvinceValue);

    // --- District ---
    final availableDistricts =
        pakLocationData[selectedProvinceValue]?.keys.toList() ?? [];
    final matchedDistrict = availableDistricts.firstWhere(
      (d) => detectedDistrict.toLowerCase().contains(d.toLowerCase()),
      orElse: () => '',
    );
    final selectedDistrictValue =
        matchedDistrict.isNotEmpty ? matchedDistrict : detectedDistrict;
    selectedDistrict(selectedDistrictValue);

    // --- Zone ---
    final availableZones =
        pakLocationData[selectedProvinceValue]?[selectedDistrictValue] ?? [];
    final matchedZone = availableZones.firstWhere(
      (z) => detectedZone.toLowerCase().contains(z.toLowerCase()),
      orElse: () => '',
    );
    final selectedZoneValue =
        matchedZone.isNotEmpty ? matchedZone : detectedZone;

    selectedZone(selectedZoneValue);

    print(
        '✅ Selected -> Province: ${selectedProvine.value} | District: ${selectedDistrict.value} | Zone: ${selectedZone.value}');
    isloading.value = false;
  }
}
