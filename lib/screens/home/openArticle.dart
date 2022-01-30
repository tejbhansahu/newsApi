import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:newsapi/common/utils/colors.dart';
import 'package:newsapi/common/utils/textStyle.dart';
import 'package:newsapi/model/model_news.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenArticle extends StatefulWidget {
  const OpenArticle({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  _OpenArticleState createState() => _OpenArticleState();
}

class _OpenArticleState extends State<OpenArticle> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                  tag: widget.article.publishedAt.toString(),
                  child: CachedNetworkImage(
                    imageUrl: widget.article.urlToImage ?? '',
                    fit: BoxFit.fitWidth,
                    errorWidget: (context, string, dynamic) {
                      return Image.asset(
                        "assets/images/placeholder.jpg",
                        fit: BoxFit.cover,
                        width: size.width,
                      );
                    },
                  )),
              Positioned(
                  bottom: 10,
                  left: 0,
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 50.0,
                            spreadRadius: 10.0)
                      ],
                    ),
                    child: Text(
                      "${widget.article.title!}...",
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.titleStyle(
                        size: 16,
                        isBold: true,
                        colors: Colors.white,
                      ),
                    ),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.article.source!.name!,
                  style: CustomTextStyle.titleStyle(
                      size: 18,
                      colors: Colors.black.withOpacity(0.8),
                      isBold: true,
                      isItalic: true),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    Jiffy({
                      "year": widget.article.publishedAt!.year,
                      "month": widget.article.publishedAt!.month,
                      "day": widget.article.publishedAt!.day,
                      "hour": widget.article.publishedAt!.hour,
                      "minute": widget.article.publishedAt!.minute,
                      "second": widget.article.publishedAt!.second,
                    }).yMMMMEEEEdjm,
                    style: CustomTextStyle.titleStyle(
                        size: 14, colors: Colors.grey),
                  ),
                ),
                Text(
                  widget.article.description!,
                  style: CustomTextStyle.titleStyle(size: 17, letterSpacing: 1),
                )
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          Container(
            width: 170,
            padding: EdgeInsets.only(left: 20, bottom: 30),
            child: TextButton(
              onPressed: () {
                _launchURL(widget.article.url!);
              },
              child: Row(
                children: [
                  Text(
                    "See full story",
                    style: CustomTextStyle.titleStyle(
                        size: 18, colors: primaryColor),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: primaryColor,
                    size: 17,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
