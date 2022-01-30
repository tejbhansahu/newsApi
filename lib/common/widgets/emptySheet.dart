import 'package:flutter/material.dart';

Future<dynamic> emptySheet(BuildContext context,
    {required StatefulWidget statefulWidget,
    double? cornerRadius,
    double? height}) {
  return showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(cornerRadius ?? 0),
            topLeft: Radius.circular(cornerRadius ?? 0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
          return SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: height ?? 110,
                child: statefulWidget,
              ));
        });
      });
}
