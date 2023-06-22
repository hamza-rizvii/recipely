import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:recipely/utils/bloc_global/vm_global.dart';

enum EnumsGlobal {
  update,
  getTheme,
  checkFirstStart,
}

class BlocGlobal {
  /// VIEW MODEL
  ViewModelGlobal? viewModel;

  /// State Stream
  final _streamController = StreamController<Object>();

  Stream<Object> get stateStream => _streamController.stream;

  StreamSink<Object> get stateSink => _streamController.sink;

  /// Event Sink
  final _eventController = StreamController<EnumsGlobal>();

  Stream<EnumsGlobal> get eventStream => _eventController.stream;

  StreamSink<EnumsGlobal> get eventSink => _eventController.sink;

  /// CONSTRUCTOR
  BlocGlobal({required BuildContext context}) {
    viewModel = ViewModelGlobal(buildContext: context);
    _eventController.stream.listen((event) {
      switch (event) {
        case EnumsGlobal.update:
          _update();
          break;
        case EnumsGlobal.getTheme:
          break;
        case EnumsGlobal.checkFirstStart:
          break;
      }
    });
  }

  initialize() async {
    _getDeviceHeightWidth();
  }


  _update() {
    stateSink.add(Object);
  }

  _getDeviceHeightWidth() {
    viewModel!.deviceHeight =
        MediaQuery.of(viewModel!.buildContext).size.height;
    viewModel!.deviceWidth = MediaQuery.of(viewModel!.buildContext).size.width;
  }
}

BlocGlobal? blocGlobal;
