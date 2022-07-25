import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:newsapi/common/utils/textStyle.dart';
import 'package:newsapi/model/model_news.dart';
import 'package:newsapi/navigation/Naviagation.dart';

Widget newsCardWidget(BuildContext context,
    {required Size size, required Article article}) {
  return Column(
    children: [
      GestureDetector(
        onTap: () => Navigation.openArticle(context, article: article),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          shadowColor: Colors.black45,
          child: Container(
            height: 150,
            padding: const EdgeInsets.all(10.0),
            child: Stack(children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 0, bottom: 10),
                        width: size.width * 0.5,
                        child: Text(
                          article.source!.name!,
                          style: CustomTextStyle.titleStyle(
                              size: 18,
                              colors: Colors.black.withOpacity(0.8),
                              isBold: true,
                              isItalic: true),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.56,
                        child: Text(
                          article.title!.length < 70
                              ? article.title!
                              : "${article.title!.substring(0, 70)}...",
                          style: CustomTextStyle.titleStyle(
                              size: 17, colors: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 110,
                    height: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Hero(
                        tag: article.publishedAt.toString(),
                        child: CachedNetworkImage(
                          imageUrl: article.urlToImage ?? '',
                          fit: BoxFit.cover,
                          errorWidget: (context, string, dynamic) {
                            return Image.asset(
                              "assets/images/placeholder.jpg",
                              fit: BoxFit.cover,
                              height: 140,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                  bottom: 5,
                  left: 0,
                  child: Text(Jiffy({
                    "year": article.publishedAt!.year,
                    "month": article.publishedAt!.month,
                    "day": article.publishedAt!.day,
                    "hour": article.publishedAt!.hour,
                    "minute": article.publishedAt!.minute
                  }).fromNow()))
            ]),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}
