import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsSlider extends StatelessWidget {
  const NewsSlider({
    super.key,
    required this.activeSliderIndex,
    required this.sliderItemList,
    required this.onPageChanged,
    required this.onNewsTapped,
    required this.onViewAllTapped,
  });

  final int activeSliderIndex;
  final List<ArticleModel> sliderItemList;
  final Function(int) onPageChanged;
  final Function(String?) onNewsTapped;
  final Function() onViewAllTapped;

  @override
  Widget build(BuildContext context) {
    return sliderItemList.isEmpty ? Container() : Column(
      children: [
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Breaking News!",
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
        CarouselSlider.builder(
          itemCount: sliderItemList.length,
          itemBuilder: (context, index, realIndex) {
            return buildSliderItem(
              sliderItemList[index],
              index,
              context,
              onNewsTapped,
            );
          },
          options: CarouselOptions(
            height: 250,
            autoPlay: true,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              onPageChanged(index);
            },
          ),
        ),
        SizedBox(height: 30),
        AnimatedSmoothIndicator(
          activeIndex: activeSliderIndex,
          count: sliderItemList.length,
          effect: ExpandingDotsEffect(),
        ),
      ],
    );
  }

  Widget buildSliderItem(ArticleModel sliderModel, int index, BuildContext context, Function(String?) onNewsTapped,) {
    return GestureDetector(
      onTap: () {
        onNewsTapped(sliderModel.url);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: sliderModel.urlToImage ?? "Image missing",
                height: 250,
                fit: BoxFit.cover,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 170),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Text(
                  sliderModel.title ?? "Title missing",
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
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