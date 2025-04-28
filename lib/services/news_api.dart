import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:http/http.dart' as http;
import 'package:news_app/category_enum.dart';
import 'package:news_app/configuration.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/article_api.dart';

import '../env.dart';

class NewsApi extends ArticleApi{
  List<ArticleModel> trendingArticleList = [];
  List<ArticleModel> topArticleList = [];
  Map<String, List<ArticleModel>> articleListByCategory = {};

  NewsApi(){
    if(Configuration.testing) {
      for (var i = 0; i < 10; i++) {
        trendingArticleList.add(
          ArticleModel(
            author: "Abha Bhattarai, Scott Clement, Emily Guskin",
            title: "Most Americans disapprove of Trump on tariffs, Post-ABC-Ipsos poll finds - The Washington Post",
            description: "Most Americans say they disapprove of Trump’s tariff policies and worry about inflation, a new Post-ABC-Ipsos poll finds.",
            url: "https://www.washingtonpost.com/business/2025/04/25/trump-tariffs-poll-approval/",
            urlToImage: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/HNV3SXTQW3BLM334EYFC4Y4WPQ.jpg&w=1440",
            content: "Nearly 2 out of 3 Americans disapprove of President Donald Trumps handling of tariffs, a rebuke of the administrations flagship economic policy, according to a Washington Post-ABC News-Ipsos national",
          ),
        );
      }

      for (var i = 0; i < 10; i++) {
        topArticleList.add(
          ArticleModel(
            author: "Abha Bhattarai, Scott Clement, Emily Guskin",
            title: "Most Americans disapprove of Trump on tariffs, Post-ABC-Ipsos poll finds - The Washington Post",
            description: "Most Americans say they disapprove of Trump’s tariff policies and worry about inflation, a new Post-ABC-Ipsos poll finds.",
            url: "https://www.washingtonpost.com/business/2025/04/25/trump-tariffs-poll-approval/",
            urlToImage: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/HNV3SXTQW3BLM334EYFC4Y4WPQ.jpg&w=1440",
            content: "Nearly 2 out of 3 Americans disapprove of President Donald Trumps handling of tariffs, a rebuke of the administrations flagship economic policy, according to a Washington Post-ABC News-Ipsos national",
          ),
        );
      }

      for(var category in CategoryEnum.values){
        List<ArticleModel> articleList = [];
        for (var i = 0; i < 5; i++){
          articleList.add(
            ArticleModel(
              author: "Abha Bhattarai, Scott Clement, Emily Guskin",
              title: "Most Americans disapprove of Trump on tariffs, Post-ABC-Ipsos poll finds - The Washington Post",
              description: "Most Americans say they disapprove of Trump’s tariff policies and worry about inflation, a new Post-ABC-Ipsos poll finds.",
              url: "https://www.washingtonpost.com/business/2025/04/25/trump-tariffs-poll-approval/",
              urlToImage: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/HNV3SXTQW3BLM334EYFC4Y4WPQ.jpg&w=1440",
              content: "Nearly 2 out of 3 Americans disapprove of President Donald Trumps handling of tariffs, a rebuke of the administrations flagship economic policy, according to a Washington Post-ABC News-Ipsos national",
            ),
          );
        }
        articleListByCategory[category.name] = articleList;
      }
    }

  }

  @override
  Future<List<ArticleModel>> getTopArticleList([int pageSize = -1]) async {
    if (topArticleList.length >= pageSize) {
      return pageSize < 1 ? topArticleList : topArticleList.sublist(0, pageSize);
    }else{
      topArticleList.clear();
    }

    var queryParameters = {
      "sources": "techcrunch",
      "apiKey": Env.newsApiKey,
    };

    var url = Uri.https("newsapi.org", "/v2/top-headlines", queryParameters);
    var response = await http.get(url);

    var json = jsonDecode(response.body);
    if (json["status"] != "ok") {
      log("Failed to fetch data");
      log(json["status"]);
      return [];
    }
    topArticleList = jsonToArticleModelList(json);

    int articleCount = math.min(pageSize, topArticleList.length);
    return pageSize < 1 ? topArticleList : topArticleList.sublist(0, articleCount);
  }

  @override
  Future<List<ArticleModel>> getTrendingArticleList([int pageSize = -1]) async {
    if (trendingArticleList.length >= pageSize) {
      return pageSize < 1 ? trendingArticleList : trendingArticleList.sublist(0, pageSize);
    }else{
      trendingArticleList.clear();
    }

    var queryParameters = {
      "sortBy": "popularity",
      "sources": "techcrunch",
      "apiKey": Env.newsApiKey,
    };

    var url = Uri.https("newsapi.org", "/v2/everything", queryParameters);

    var response = await http.get(url);

    var json = jsonDecode(response.body);
    if (json["status"] != "ok") {
      log("Failed to fetch data");
      return [];
    }
    trendingArticleList = jsonToArticleModelList(json);

    int articleCount = math.min(pageSize, trendingArticleList.length);
    return pageSize < 1 ? trendingArticleList : trendingArticleList.sublist(0, articleCount);
  }

  @override
  Future<List<ArticleModel>> getArticleListByCategory(String category) async {
    category = category.toLowerCase();
    if(articleListByCategory.containsKey(category)){
      return articleListByCategory[category]!;
    }

    var url = Uri.https("newsapi.org", "/v2/top-headlines", {
      "category": category,
      "apiKey": Env.newsApiKey,
    });

    var response = await http.get(url);

    var json = jsonDecode(response.body);
    if (json["status"] != "ok") {
      log("Failed to fetch data");
      return [];
    }

    articleListByCategory[category] = jsonToArticleModelList(json);
    return articleListByCategory[category]!;
  }

  List<ArticleModel> jsonToArticleModelList(json) {
    List<ArticleModel> articleList = [];

    json["articles"].forEach(
          (article) => {
        if (article['title'] != null && article['urlToImage'] != null &&
            article['url'] != null){
          articleList.add(
            ArticleModel(
              author: article['author'],
              title: article['title'],
              description: article['description'],
              url: article['url'],
              urlToImage: article['urlToImage'],
              content: article['content'],
            ),
          ),
        },
      },
    );
    return articleList;
  }
}
