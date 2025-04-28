import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArticleTile extends StatelessWidget{
  final String urlToImage, title, description, url;
  final Function(String?) onTapped;

  const ArticleTile({
    super.key,
    required this.urlToImage,
    required this.title,
    required this.description,
    required this.url,
    required this.onTapped
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapped(url);
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: urlToImage,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5,),
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),
          ),
          Text(description),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

}