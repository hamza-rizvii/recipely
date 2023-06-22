import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/bloc_global/bloc_global.dart';
import 'utils/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const Recipely());
}

class Recipely extends StatelessWidget {
  const Recipely({super.key});

  @override
  Widget build(BuildContext context) {
    ///////////////////////////////////////////
    // Bloc Global
    blocGlobal = BlocGlobal(context: context);
    blocGlobal!.initialize();
    ///////////////////////////////////////////
    return MaterialApp(
      initialRoute: '/splash',
      routes: AppRoutes(context: context).routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.white,
          ),
          primaryColor: Colors.black,
          primarySwatch: const MaterialColor(0xff000000, {
            50: Color(0xff000000),
            100: Color(0xff000000),
            200: Color(0xff000000),
            300: Color(0xff000000),
            400: Color(0xff000000),
            500: Color(0xff000000),
            600: Color(0xff000000),
            700: Color(0xff000000),
            800: Color(0xff000000),
            900: Color(0xff000000)
          })),
    );
  }
}
