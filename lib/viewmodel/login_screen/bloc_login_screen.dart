import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipely/utils/bloc_global/bloc_global.dart';
import 'vm_login_screen.dart';

enum EnumsLoginScreen {
  update,
  animate,
  navigate,
  login,
}

class BlocLoginScreen {
  late ViewModelSplashScreen viewModel;

  //////////////////////////////////////////////////////////////////////////////
  // EMAIL CONTROLLER
  TextEditingController emailController = TextEditingController();

  // PASSWORD CONTROLLER
  TextEditingController passwordController = TextEditingController();

  //////////////////////////////////////////////////////////////////////////////

  /// State Controller
  final _stateController = StreamController<Object>();

  StreamSink<Object> get _stateSink => _stateController.sink;

  Stream<Object> get stateStream => _stateController.stream;

  /// Event Controller
  final _eventController = StreamController<EnumsLoginScreen>();

  StreamSink<EnumsLoginScreen> get eventSink => _eventController.sink;

  /// CONSTRUCTOR
  BlocLoginScreen({required BuildContext context}) {
    /// INITIALIZING INDEX
    viewModel = ViewModelSplashScreen(context: context);

    /// INITIALIZE ANIMATION METRICS
    _initAnimationMetrics();

    /// Listening to events
    _eventController.stream.listen((event) {
      switch (event) {
        case EnumsLoginScreen.update:
          _update();
          break;
        case EnumsLoginScreen.animate:
          _animate();
          break;
        case EnumsLoginScreen.navigate:
          _navigate();
          break;
        case EnumsLoginScreen.login:
          _login();
      }
    });
  }

  _update() {
    _stateSink.add(Object);
  }

  _animate() {
    BuildContext context;
    viewModel.emailPasswordBoxWidth =
        blocGlobal!.viewModel!.deviceWidth as double;
    viewModel.loginButtonWidth = blocGlobal!.viewModel!.deviceWidth as double;
    viewModel.socialButtonsWidth = blocGlobal!.viewModel!.deviceWidth as double;

    _update();
  }

  _navigate() {
    Navigator.pushNamedAndRemoveUntil(
        viewModel.context, '/searchScreen', (route) => false);
  }

  _initAnimationMetrics() {
    viewModel.emailPasswordBoxWidth = blocGlobal!.viewModel!.deviceWidth! * 0.8;
    viewModel.loginButtonWidth = blocGlobal!.viewModel!.deviceWidth! * 0.8;
    viewModel.socialButtonsWidth = blocGlobal!.viewModel!.deviceWidth! * 0.7;
  }

  _login() async {
    _navigate();
    // viewModel.isLoading = true;
    // // UPDATE VIEW TO SHOW LOADER
    // _update();
    // // TRY FIREBASE LOGIN
    // if (emailController.text.isEmpty) {
    //   _showErrorDialog(msg: 'Please enter a valid email address');
    // } else if (passwordController.text.isEmpty) {
    //   _showErrorDialog(msg: 'Please enter password');
    // } else {
    //   try {
    //     final credential = await FirebaseAuth.instance
    //         .signInWithEmailAndPassword(
    //             email: emailController.text.toString(),
    //             password: passwordController.text.toString());
    //     if (credential.user != null) {
    //       /// LOGIN SUCCESSFUL
    //       _navigate();
    //     }
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'user-not-found') {
    //       _showErrorDialog(msg: 'No user found for that email.');
    //     } else if (e.code == 'wrong-password') {
    //       _showErrorDialog(msg: 'Wrong password provided for that user.');
    //     } else {
    //       _showErrorDialog(msg: e.message.toString());
    //     }
    //   }
    // }
    // // HIDE LOADER
    // viewModel.isLoading = false;
    // _update();
  }

  _showErrorDialog({required String msg}) {
    showDialog(
        context: viewModel.context,
        builder: (context) {
          return AlertDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Authentication Error'),
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                )
              ],
            ),
            content: Text(msg),
          );
        });
  }
}
