import 'package:flutter/material.dart';
import 'package:newsapi/animation/fade_page_route.dart';
import 'package:newsapi/model/model_news.dart';
import 'package:newsapi/screens/home/openArticle.dart';

class Navigation {
  static openArticle(BuildContext context, {required Article article}) {
    return Navigator.push(
        context,
        FadePageRoute(
            fullscreenDialog: true,
            builder: (context) => OpenArticle(
                  article: article,
                )));
  }
}
