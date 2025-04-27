import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../common/widgets/custom_app_bar.dart';

class ArticleView extends StatefulWidget{
  const ArticleView({super.key, required this.url});

  final String url;

  @override
  State<StatefulWidget> createState() => _ArticleViewState();


}

class _ArticleViewState extends State<ArticleView>{
  var controller;

  @override
  void initState() {
    controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        body: WebViewWidget(controller: controller)
    );
  }
}