import 'dart:ffi';

import '../models/article_model.dart';
import '../models/slider_item_model.dart';

abstract class ArticleApi{
  Future<List<ArticleModel>> getTrendingArticleList([int pageSize]);
  Future<List<ArticleModel>> getTopArticleList([int pageSize]);
  Future<List<ArticleModel>> getArticleListByCategory(String category);
}