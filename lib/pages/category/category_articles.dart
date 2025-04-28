import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/article_api.dart';
import 'package:news_app/services/news_api.dart';

import '../common/widgets/article_tile.dart';

class CategoryArticles extends StatefulWidget{
  final String category;
  final Function(String?) handleArticleTapped;

  const CategoryArticles({super.key, required this.category, required this.handleArticleTapped});

  @override
  State<StatefulWidget> createState() => _CategoryArticlesState();
}

class _CategoryArticlesState extends State<CategoryArticles> {
  List<ArticleModel> articleList = [];
  bool _loading = true;
  ArticleApi articleApi = NewsApi();

  @override
  void initState() {
    getNewsByCategory(widget.category);
    super.initState();
  }

  getNewsByCategory(String category) async {
    var articleList = await articleApi.getArticleListByCategory(category);

    setState(() {
      _loading = false;
      this.articleList = articleList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _loading ? Center(child: CircularProgressIndicator()) : Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: articleList.length,
          itemBuilder: (context, index) {
            return ArticleTile(
              urlToImage: articleList[index].urlToImage!,
              title: articleList[index].title!,
              description: articleList[index].description!,
              url: articleList[index].url!,
              onTapped: widget.handleArticleTapped,
            );
          },
        )
      )
    );
  }
}