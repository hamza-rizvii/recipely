import 'package:flutter/material.dart';
import 'package:recipely/view/login_screen/login_screen.dart';
import 'package:recipely/view/search_screen/search_screen.dart';
import 'package:recipely/view/splash_screen/splash_screen.dart';

class AppRoutes {
  late BuildContext context;
  late Map<String, Widget Function(BuildContext)> routes;

  AppRoutes({required this.context}) {
    routes = <String, Widget Function(BuildContext)>{
      '/splash': (context) => SplashScreen(),
      '/login': (context) => LoginScreen(),
      '/searchScreen': (context) => SearchScreen(),
    };
  }
}
