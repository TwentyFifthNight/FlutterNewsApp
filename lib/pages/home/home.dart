import 'package:flutter/material.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/pages/article/article_view.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/pages/category/category_articles.dart';
import 'package:news_app/pages/home/widgets/news_slider.dart';
import 'package:news_app/pages/home/widgets/trending_news.dart';
import 'package:news_app/pages/view_all/view_all.dart';
import 'package:news_app/services/article_api.dart';
import 'package:news_app/services/category_data.dart';
import 'package:news_app/services/news_api.dart';
import 'package:news_app/util/article_provider.dart';

import '../common/widgets/custom_app_bar.dart';
import 'widgets/category_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  ArticleApi articleApi = NewsApi();

  List<CategoryModel> categoryList = [];
  List<ArticleModel> sliderArticleList = [];
  List<ArticleModel> trendingArticleList = [];
  bool _loading = true;

  int activeSliderIndex = 0;

  @override
  void initState() {
    categoryList = getCategories();
    getSliderArticles();
    getNews();
    super.initState();
  }

  getNews() async {
    var trendingArticleList = await articleApi.getTrendingArticleList(10);
    setState(() {
      _loading = false;
      this.trendingArticleList = trendingArticleList;
    });
  }

  getSliderArticles() async {
    var sliderArticleList = await articleApi.getTopArticleList(5);
    setState(() {
      this.sliderArticleList = sliderArticleList;
    });
  }

  void handleCarouselPageChanged(int index){
    setState(() {
      activeSliderIndex = index;
    });
  }

  void handleNewsClicked(String? url){
    if(url != null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(url: url)));
    }
  }

  void handleCategoryClicked(String category){
    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryArticles(category: category, handleArticleTapped: handleNewsClicked,)));
  }

  void handleViewAllTopArticles(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AllArticles(
      articleType: "Breaking",
      handleArticleTapped: handleNewsClicked,
      articleProvider: ArticleProvider(getArticles: () async {
        return await articleApi.getTopArticleList();
      }),
    )));
  }

  void handleViewALlTrendingArticles(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AllArticles(
      articleType: "Trending",
      handleArticleTapped: handleNewsClicked,
      articleProvider: ArticleProvider(getArticles: () async {
        return await articleApi.getTrendingArticleList();
      }),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: _loading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Column(
          children: [
            CategoryList(
                categoryList: categoryList,
                handleCategoryClicked: handleCategoryClicked
            ),
            NewsSlider(
              activeSliderIndex: activeSliderIndex,
              sliderItemList: sliderArticleList,
              onPageChanged: handleCarouselPageChanged,
              onNewsTapped: handleNewsClicked,
              onViewAllTapped: handleViewAllTopArticles,
            ),
            SizedBox(height: 30),
            TrendingNews(
              articleList: trendingArticleList,
              onNewsTapped: handleNewsClicked,
              onViewAllTapped: handleViewALlTrendingArticles,
            ),
          ],
        ),
      ),
    );
  }
}
