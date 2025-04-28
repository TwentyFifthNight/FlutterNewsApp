import 'package:flutter/material.dart';

import '../../../models/category_model.dart';

class CategoryList extends StatelessWidget{
  final List<CategoryModel> categoryList;
  final Function(String) handleCategoryClicked;

  const CategoryList({
    super.key,
    required this.categoryList,
    required this.handleCategoryClicked
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 70,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return buildCategoryTile(
            categoryList[index].image!,
            categoryList[index].name!,
            handleCategoryClicked,
          );
        },
      ),
    );
  }

  Widget buildCategoryTile(String image, String name, Function(String) onCategoryTapped){
    final double imageWidth = 130, imageHeight = 60;

    return Container(
      margin: EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          onCategoryTapped(name);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                image,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: imageWidth,
              height: imageHeight,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
