import 'package:flutter/material.dart';
import 'package:newsapi/common/utils/textStyle.dart';
import 'package:newsapi/provider/homeProvider.dart';
import 'package:provider/provider.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
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
                "Choose your location",
                style: CustomTextStyle.titleStyle(size: 18, isBold: true),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            radioList(value),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    value.articles.clear();
                    value.resetSources();
                    value.fetchNews();
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

  Widget radioList(HomeProvider value) {
    return Expanded(
      child: ListView.builder(
          itemCount: value.allCountries.length,
          itemBuilder: (cxt, index) {
            var map = value.allCountries.entries.elementAt(index);
            return ListTile(
              title: Text(map.key),
              trailing: Radio(
                value: map.key,
                groupValue: value.selectedCountry.keys.first,
                onChanged: (data) {
                  value.updateLocation(country: {data.toString(): map.value});
                },
              ),
              onTap: () {
                value.updateLocation(country: {map.key: map.value});
              },
            );
          }),
    );
  }
}
