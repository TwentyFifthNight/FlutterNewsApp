import 'package:flutter/material.dart';
import 'package:news_app/util/article_provider.dart';

import '../../models/article_model.dart';
import '../common/widgets/article_tile.dart';

class AllArticles extends StatefulWidget{
  final String articleType;
  final ArticleProvider articleProvider;
  final Function(String?) handleArticleTapped;

  const AllArticles({
    super.key,
    required this.articleType,
    required this.articleProvider,
    required this.handleArticleTapped
  });


  @override
  State<StatefulWidget> createState() => _AllArticlesState();
}

class _AllArticlesState extends State<AllArticles>{
  List<ArticleModel> articleList = [];
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.articleType} News",
          style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold
          ),
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
      ),
    );
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  getNews() async {
    var articleList = await widget.articleProvider.getArticles();

    setState(() {
      _loading = false;
      this.articleList = articleList;
    });
  }

}