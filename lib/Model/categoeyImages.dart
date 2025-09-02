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
      "smartphones":
          "https://images.pexels.com/photos/788946/pexels-photo-788946.jpeg",
      "laptops":
          "https://images.pexels.com/photos/812264/pexels-photo-812264.jpeg",
      "fragrances":
          "https://images.pexels.com/photos/1040424/pexels-photo-1040424.jpeg",
      "skincare":
          "https://images.pexels.com/photos/4041392/pexels-photo-4041392.jpeg",
      "groceries":
          "https://images.pexels.com/photos/264636/pexels-photo-264636.jpeg",
      "home-decoration":
          "https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg",
      "beauty":
          "https://images.pexels.com/photos/3373736/pexels-photo-3373736.jpeg",
      "furniture":
          "https://images.pexels.com/photos/1866149/pexels-photo-1866149.jpeg",
      "kitchen-accessories":
          "https://images.pexels.com/photos/205926/pexels-photo-205926.jpeg",
      "mens-shirts":
          "https://images.pexels.com/photos/297933/pexels-photo-297933.jpeg",
      "mens-shoes":
          "https://images.pexels.com/photos/2529157/pexels-photo-2529157.jpeg",
      "mens-watches":
          "https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg",
      "mobile-accessories":
          "https://images.pexels.com/photos/1275929/pexels-photo-1275929.jpeg",
      "motorcycle":
          "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg",
      "sunglasses":
          "https://images.pexels.com/photos/701877/pexels-photo-701877.jpeg",
      "vehicle":
          "https://images.pexels.com/photos/112460/pexels-photo-112460.jpeg",
      "womens-bags":
          "https://images.pexels.com/photos/8532616/pexels-photo-8532616.jpeg",
      "womens-dresses":
          "https://images.pexels.com/photos/985635/pexels-photo-985635.jpeg",
      "womens-jewellery":
          "https://images.pexels.com/photos/965981/pexels-photo-965981.jpeg",
      "womens-shoes":
          "https://images.pexels.com/photos/267301/pexels-photo-267301.jpeg",
      "womens-watches":
          "https://images.pexels.com/photos/125779/pexels-photo-125779.jpeg",
      "default":
          "https://images.pexels.com/photos/356056/pexels-photo-356056.jpeg"
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
