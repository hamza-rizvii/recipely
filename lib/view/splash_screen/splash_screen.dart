import 'package:flutter/material.dart';
import 'package:recipely/utils/constants/my_constants.dart';
import 'package:recipely/viewmodel/splash_screen/bloc_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// BLOC
  late BlocSplashScreen bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// INITIALIZING BLOC CONTEXT
    bloc = BlocSplashScreen(context: context);

    /// ANIMATING LOGO
    bloc.eventSink.add(EnumsSplashScreen.animate);

    /// NAVIGATING
    bloc.eventSink.add(EnumsSplashScreen.navigate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstants.splashScreenBackground,
      body: Container(
        alignment: Alignment.center,
        child: StreamBuilder<Object>(
            stream: bloc.stateStream,
            builder: (context, snapshot) {
              return AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: Curves.ease,
                height: bloc.viewModel.taglineHeight,
                width: double.infinity,
                child: const Text(
                  'Recipely',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 34.0),
                ),
              );
            }),
      ),
    );
  }
}
