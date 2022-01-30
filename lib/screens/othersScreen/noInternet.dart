import 'package:flutter/material.dart';
import 'package:newsapi/common/utils/colors.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/no-wifi.png",
              height: 100,
              width: 100,
            ),
          ),
          const Text("No Internet Connection!"),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Try again"),
            ),
          )
        ],
      ),
    );
  }
}
