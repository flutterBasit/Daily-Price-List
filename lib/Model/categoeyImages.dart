// // models/category_model.dart
// class CategoryModel {
//   final String name;
//   final String image;

//   CategoryModel({required this.name, required this.image});

//   // Since DummyJSON does not provide images for categories,
//   // we map them manually
//   static List<CategoryModel> fromList(List categories) {
//     final Map<String, String> categoryImages = {
//       "smartphones": "https://cdn-icons-png.flaticon.com/512/104/104985.png",
//       "laptops": "https://cdn-icons-png.flaticon.com/512/679/679720.png",
//       "fragrances": "https://cdn-icons-png.flaticon.com/512/1053/1053244.png",
//       "skincare": "https://cdn-icons-png.flaticon.com/512/2927/2927347.png",
//       "groceries": "https://cdn-icons-png.flaticon.com/512/1046/1046784.png",
//       "home-decoration":
//           "https://cdn-icons-png.flaticon.com/512/2965/2965567.png",
//     };

//     return categories
//         .map((c) => CategoryModel(name: c, image: categoryImages[c] ?? ""))
//         .toList();
//   }
// }

// models/category_model.dart
class CategoryModel {
  final String name;
  final String image;

  CategoryModel({required this.name, required this.image});

  static List<CategoryModel> fromList(List categories) {
    final Map<String, String> categoryImages = {
      "smartphones": "https://cdn-icons-png.flaticon.com/512/104/104985.png",
      "laptops": "https://cdn-icons-png.flaticon.com/512/679/679720.png",
      "fragrances": "https://cdn-icons-png.flaticon.com/512/1053/1053244.png",
      "skincare": "https://cdn-icons-png.flaticon.com/512/2927/2927347.png",
      "groceries": "https://cdn-icons-png.flaticon.com/512/1046/1046784.png",
      "home-decoration":
          "https://cdn-icons-png.flaticon.com/512/2965/2965567.png",
      "beauty":
          "https://cdn-icons-png.flaticon.com/512/2945/2945448.png", // Added
      "furniture":
          "https://cdn-icons-png.flaticon.com/512/3320/3320055.png", // Added
      "kitchen-accessories":
          "https://cdn-icons-png.flaticon.com/512/284/284691.png", // Added
      "mens-shirts":
          "https://cdn-icons-png.flaticon.com/512/206/206853.png", // Added
      "mens-shoes":
          "https://cdn-icons-png.flaticon.com/512/2589/2589900.png", // Added
      "mens-watches":
          "https://cdn-icons-png.flaticon.com/512/206/206811.png", // Added
      "mobile-accessories":
          "https://cdn-icons-png.flaticon.com/512/2973/2973316.png", // Added
      "motorcycle":
          "https://cdn-icons-png.flaticon.com/512/1042/1042339.png", // Added
      "sunglasses":
          "https://cdn-icons-png.flaticon.com/512/1170/1170678.png", // Added
      "vehicle":
          "https://cdn-icons-png.flaticon.com/512/744/744465.png", // Added
      "womens-bags":
          "https://cdn-icons-png.flaticon.com/512/1037/1037856.png", // Added
      "womens-dresses":
          "https://cdn-icons-png.flaticon.com/512/206/206869.png", // Added
      "womens-jewellery":
          "https://cdn-icons-png.flaticon.com/512/2933/2933245.png", // Added
      "womens-shoes":
          "https://cdn-icons-png.flaticon.com/512/2589/2589903.png", // Added
      "womens-watches":
          "https://cdn-icons-png.flaticon.com/512/206/206811.png", // Added
    };

    return categories.map((c) {
      // Extract category name from the object
      String categoryName;
      if (c is String) {
        // If it's already a string (old format)
        categoryName = c;
      } else if (c is Map<String, dynamic>) {
        // If it's an object with name property (new format)
        categoryName = c['name'] ?? '';
      } else {
        categoryName = '';
      }

      return CategoryModel(
        name: categoryName,
        image: categoryImages[categoryName.toLowerCase()] ??
            "https://cdn-icons-png.flaticon.com/512/1178/1178475.png", // Default icon
      );
    }).toList();
  }
}
