// models/category_model.dart
class CategoryModel {
  final String name;
  final String image;

  CategoryModel({required this.name, required this.image});

  // Since DummyJSON does not provide images for categories,
  // we map them manually
  static List<CategoryModel> fromList(List categories) {
    final Map<String, String> categoryImages = {
      "smartphones": "https://cdn-icons-png.flaticon.com/512/104/104985.png",
      "laptops": "https://cdn-icons-png.flaticon.com/512/679/679720.png",
      "fragrances": "https://cdn-icons-png.flaticon.com/512/1053/1053244.png",
      "skincare": "https://cdn-icons-png.flaticon.com/512/2927/2927347.png",
      "groceries": "https://cdn-icons-png.flaticon.com/512/1046/1046784.png",
      "home-decoration":
          "https://cdn-icons-png.flaticon.com/512/2965/2965567.png",
    };

    return categories
        .map((c) => CategoryModel(name: c, image: categoryImages[c] ?? ""))
        .toList();
  }
}
