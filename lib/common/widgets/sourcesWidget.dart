import 'package:flutter/material.dart';
import 'package:newsapi/common/utils/colors.dart';
import 'package:newsapi/common/utils/textStyle.dart';
import 'package:newsapi/provider/homeProvider.dart';
import 'package:provider/provider.dart';

class Sources extends StatefulWidget {
  const Sources({Key? key}) : super(key: key);

  @override
  _SourcesState createState() => _SourcesState();
}

class _SourcesState extends State<Sources> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, child) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.grey.shade400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Filter by sources",
                style: CustomTextStyle.titleStyle(size: 18, isBold: true),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            checkBoxList(value),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    List<String> sources = [];
                    value.allSources.forEach((key, value) {
                      if (value) sources.add(key);
                    });
                    value.articles.clear();
                    value.fetchNews(
                        isFiltering: sources.isNotEmpty ? true : false,
                        sources: sources.isNotEmpty
                            ? sources.reduce(
                                (value, element) => value + ',' + element)
                            : null);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Text(
                      "Apply",
                      style: CustomTextStyle.titleStyle(
                          size: 20, colors: Colors.white),
                    ),
                  )),
            ))
          ],
        ),
      );
    });
  }

  Widget checkBoxList(HomeProvider provider) {
    return Expanded(
      child: ListView(
        children: provider.allSources.keys.map((String key) {
          return new CheckboxListTile(
            controlAffinity: ListTileControlAffinity.trailing,
            activeColor: primaryColor,
            title: Text(key),
            value: provider.allSources[key],
            onChanged: (bool? value) {
              Provider.of<HomeProvider>(context, listen: false)
                  .addSources(source: {key: value!});
            },
          );
        }).toList(),
      ),
    );
  }
}
