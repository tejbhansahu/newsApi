/*
import 'package:animations/animations.dart';

class Animations{

  static const double kDefaultDuration = 500;

  static Route<T> fadeThrough<T>(PageBuilder page, [double duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(animation: animation, secondaryAnimation: secondaryAnimation, child: child);
      },
    );
  }

  static Route<T> fadeScale<T>(PageBuilder page, [double duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }

  static Route<T> sharedAxis<T>(PageBuilder page, [SharedAxisTransitionType type = SharedAxisTransitionType.scaled, double duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: type,
        );
      },
    );
  }

}*/
