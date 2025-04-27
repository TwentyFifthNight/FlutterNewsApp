import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:news_app/category_enum.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/util/string_extension.dart';


class CategoryData {

}

List<CategoryModel> getCategories(){
  List<CategoryModel> categoryList=[];

  for(var category in CategoryEnum.values){
    categoryList.add(CategoryModel(
        category.name.capitalize(),
        "images/categories/${category.name}.jpg")
    );
  }

  return categoryList;
}