import 'dart:async';

import 'package:flutter/material.dart';

import 'vm_splash_screen.dart';

enum EnumsSplashScreen {
  update,
  animate,
  navigate,
}

class BlocSplashScreen {
  late ViewModelSplashScreen viewModel;

  /// State Controller
  final _stateController = StreamController<Object>();

  StreamSink<Object> get _stateSink => _stateController.sink;

  Stream<Object> get stateStream => _stateController.stream;

  /// Event Controller
  final _eventController = StreamController<EnumsSplashScreen>();

  StreamSink<EnumsSplashScreen> get eventSink => _eventController.sink;

  /// CONSTRUCTOR
  BlocSplashScreen({required BuildContext context}) {
    /// INITIALIZING INDEX
    viewModel = ViewModelSplashScreen(context: context);

    /// Listening to events
    _eventController.stream.listen((event) {
      switch (event) {
        case EnumsSplashScreen.update:
          _update();
          break;
        case EnumsSplashScreen.animate:
          _animate();
          break;
        case EnumsSplashScreen.navigate:
          _navigate();
          break;
      }
    });
  }

  _update() {
    _stateSink.add(Object);
  }

  _animate() {
    viewModel.taglineHeight = 120;
    _update();
  }

  _navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          viewModel.context, '/login', (route) => false);
    });
  }
}
