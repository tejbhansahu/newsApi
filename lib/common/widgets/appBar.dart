import 'package:flutter/material.dart';
import 'package:newsapi/common/utils/colors.dart';
import 'package:newsapi/common/widgets/chooseLocation.dart';
import 'package:newsapi/common/widgets/emptySheet.dart';
import 'package:newsapi/provider/homeProvider.dart';
import 'package:provider/provider.dart';

class AppBarMethod {
  static PreferredSize appBarMethod({
    required BuildContext context,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Consumer<HomeProvider>(builder: (context, value, child) {
        return AppBar(
          backgroundColor: primaryColor,
          centerTitle: false,
          elevation: 0,
          title: Text("MyNews"),
          actions: [
            GestureDetector(
              onTap: () {
                emptySheet(context,
                    statefulWidget: ChooseLocation(),
                    cornerRadius: 5,
                    height: 500);
              },
              child: Container(
                width: 100,
                padding: EdgeInsets.only(top: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Location"),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 15,
                        ),
                        Text(value.selectedCountry.entries.first.key)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
