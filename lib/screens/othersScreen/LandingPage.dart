import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:newsapi/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'noInternet.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityResult>(
      builder: (BuildContext context, value, Widget? child) {
        if (value == ConnectivityResult.none) {
          return const NoInternet();
        } else {
          return const Home();
        }
      },
    );
  }
}
