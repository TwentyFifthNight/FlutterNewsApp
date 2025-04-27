import 'package:news_app/models/article_model.dart';

class ArticleProvider{
  final Future<List<ArticleModel>> Function() getArticles;

  ArticleProvider({required this.getArticles});
}