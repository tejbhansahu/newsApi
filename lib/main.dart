import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapi/provider/homeProvider.dart';
import 'package:provider/provider.dart';
import 'common/utils/colors.dart';
import 'common/utils/connectivity_service.dart';
import 'screens/othersScreen/splashScreen.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: primaryColor,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xff0c54be, color);
    return MultiProvider(
      providers: [
        StreamProvider<ConnectivityResult>(
            initialData: ConnectivityResult.mobile,
            create: (_) {
              return ConnectivityService().connectionStatusController.stream;
            }),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeData()),
      ],
      child: MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: colorCustom,
          fontFamily: "Arial",
          primaryColor: primaryColor,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: primaryColor,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        home: const SplashScreen()
      ),
    );
  }
}

