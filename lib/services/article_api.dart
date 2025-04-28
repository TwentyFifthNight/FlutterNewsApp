import '../models/article_model.dart';

abstract class ArticleApi{
  Future<List<ArticleModel>> getTrendingArticleList([int pageSize]);
  Future<List<ArticleModel>> getTopArticleList([int pageSize]);
  Future<List<ArticleModel>> getArticleListByCategory(String category);
}