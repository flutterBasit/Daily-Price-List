import 'package:daily_price_list/Resources/Components/InternetIssue.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Explorescreen extends StatelessWidget {
  Explorescreen({super.key});

  final HomeScreen_ViewController controller =
      Get.find<HomeScreen_ViewController>();

  final List<Color> containerColor = [
    Color(0xffF8A44C),
    Color(0xff53B175),
    Color(0xffF7A593),
    Color(0xffD3B0E0),
    Color(0xffFDE598),
    Color(0xffB7Dff5)
  ];

  // @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  "Find Products",
                  style: StringsConstants.favouriteScreenTitle,
                ),
              ),
            ),
            Obx(() {
              if (controller.hasInternetError.value) {
                return Internetissue(onRefesh: () {
                  controller.fetchCategories();
                });
              }
              return Expanded(
                child: Skeletonizer(
                    enabled: controller.isLoading.value,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            // controller: TextEditingController(
                            //     text: controller.searchQuery2.value),
                            controller: controller.exploreTextController,
                            decoration: InputDecoration(
                                hintText: 'Search Store',
                                hintStyle: StringsConstants.shopSearchTextField,
                                prefixIcon: Icon(Icons.search),
                                suffixIcon: controller.searchQuery2.isNotEmpty
                                    ? IconButton(
                                        onPressed: () {
                                          controller.exploreTextController
                                              .clear();
                                          controller.search(
                                              ""); // clears search results
                                        },
                                        icon: Icon(Icons.clear))
                                    : null,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                )),
                            onChanged: (value) {
                              controller.search(value);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: controller.isSearching2.value
                              ? _buildSearchWidget()
                              : _buildNormalContent(),
                        )
                      ],
                    )),
              );
            })
          ],
        ),
      ),
    );
  }

  // Widget _buildSearchWidget() {
  //   return Center(
  //     child: Text('Search results will appear here'),
  //   );
  // }
  Widget _buildSearchWidget() {
    return Obx(() {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child:
                Text("Search Results for '${controller.searchQuery2.value}'"),
          ),
          SizedBox(height: 10.h),
          if (controller.searchResult2.isEmpty)
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text("No Categories Found"))
          else
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8, // Adjusted for category items
                ),
                itemCount: controller.searchResult2.length,
                itemBuilder: (context, index) {
                  final categoryItem = controller.searchResult2[index];
                  return _buildCategoryItem(categoryItem);
                },
              ),
            )
        ],
      );
    });
  }

  // New widget for displaying category search results
  Widget _buildCategoryItem(Map<String, dynamic> categoryItem) {
    final color = containerColor[categoryItem.hashCode % containerColor.length];

    return InkWell(
      onTap: () {
        // Navigate to category products when a category is tapped
        // controller.fetchProductsByCategory(categoryItem['name']);
        Get.toNamed(Routenames.ProductScreen, arguments: categoryItem['name']);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 2),
          color: color.withOpacity(0.15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                categoryItem['image'] ?? 'https://via.placeholder.com/150',
                fit: BoxFit.contain,
                height: 100,
                width: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.category,
                    size: 40,
                    color: color,
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                categoryItem['name'] ?? 'Category',
                style: StringsConstants.shopExclusiveTitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

//-----------if searchResult is empty -------------------------------------Categories will be displayed
  Widget _buildNormalContent() {
    return Obx(() {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8.0),
        itemCount: controller.isLoading.value ? 6 : controller.category.length,
        itemBuilder: (context, index) {
          // Show skeleton when loading
          if (controller.isLoading.value) {
            final color = containerColor[index % containerColor.length];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 60,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 16,
                    width: 60,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            );
          }

          final cat = controller.category[index];
          final color = containerColor[index % containerColor.length];
          final categoryImage = controller.getCategoryImage(cat.name);

          return InkWell(
              onTap: () {
                // controller.fetchProductsByCategory(cat.name);
                Get.toNamed(Routenames.ProductScreen, arguments: cat.name);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: color, width: 2),
                    color: color.withOpacity(0.15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: Image.network(
                        categoryImage!,
                        fit: BoxFit.contain,
                        height: 120,
                        width: 120,
                        errorBuilder: (context, index, stackTrace) {
                          return Icon(
                            Icons.error,
                            size: 40,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      cat.name,
                      style: StringsConstants.shopExclusiveTitle,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ));
        },
      );
    });
  }
}
