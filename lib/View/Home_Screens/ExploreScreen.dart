import 'package:daily_price_list/Resources/Components/InternetIssue.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Explorescreen extends StatelessWidget {
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

  Explorescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Expanded(
            child: Obx(() {
              if (controller.hasInternetError.value) {
                return Internetissue(onRefesh: () {
                  controller.fetchCategories();
                });
              }
              return Skeletonizer(
                  enabled: controller.isLoading.value,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: TextEditingController(
                                text: controller.searchQuery2.value),
                            decoration: InputDecoration(
                                hintText: 'Search Store',
                                hintStyle: StringsConstants.shopSearchTextField,
                                prefixIcon: Icon(Icons.search),
                                suffix: controller.searchQuery2.isNotEmpty
                                    ? Icon(Icons.clear)
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
                        if (controller.isSearching.value)
                          _buildSearchWidget()
                        else
                          _buildNormalContent()
                      ],
                    ),
                  ));
            }),
          )
        ],
      ),
    );
  }

  Widget _buildSearchWidget() {
    return Center();
  }

//-----------if searchResult is empty -------------------------------------Categories will be displayed

  Widget _buildNormalContent() {
    return GridView.builder(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.2),
      itemCount: controller.category.length,
      itemBuilder: (context, index) {
        final cat = controller.category[index];
        final color = containerColor[index % containerColor.length];

        return InkWell(
            onTap: () {
              controller.fetchProductsByCategory(cat.name);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: color, width: 2),
                    color: color.withOpacity(0.15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Image.network(
                        cat.image,
                        fit: BoxFit.contain,
                      ),
                    )),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      cat.name,
                      style: StringsConstants.shopExclusiveTitle,
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
