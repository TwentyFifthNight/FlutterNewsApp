import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({
    super.key,
    required this.articleList,
    required this.onNewsTapped,
    required this.onViewAllTapped,
  });

  final List<ArticleModel> articleList;
  final Function(String?) onNewsTapped;
  final Function() onViewAllTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Trending News!",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () {onViewAllTapped();},
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        for (var article in articleList)
          buildTrendingNewsItem(context, article, onNewsTapped),
      ],
    );
  }

  Widget buildTrendingNewsItem(BuildContext context, ArticleModel articleModel, Function(String?) onNewsTapped) {
    return GestureDetector(
      onTap: () {
        onNewsTapped(articleModel.url);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 4.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: articleModel.urlToImage ?? "Image missing",
                        height: MediaQuery.of(context).size.width / 3,
                        width: MediaQuery.of(context).size.width / 3,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text(
                            articleModel.title ?? "Title missing",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text(
                            articleModel.description ?? "Description missing",
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
