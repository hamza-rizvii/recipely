import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipely/utils/bloc_global/bloc_global.dart';
import 'vm_search_screen.dart';

enum EnumsSearchScreen {
  update,
  search,
}

class BlocSearchScreen {
  late ViewModelSearchScreen viewModel;

  //////////////////////////////////////////////////////////////////////////////
  // EMAIL CONTROLLER
  TextEditingController searchController = TextEditingController();

  //////////////////////////////////////////////////////////////////////////////

  /// State Controller
  final _stateController = StreamController<Object>();

  StreamSink<Object> get _stateSink => _stateController.sink;

  Stream<Object> get stateStream => _stateController.stream;

  /// Event Controller
  final _eventController = StreamController<EnumsSearchScreen>();

  StreamSink<EnumsSearchScreen> get eventSink => _eventController.sink;

  /// CONSTRUCTOR
  BlocSearchScreen({required BuildContext context}) {
    /// INITIALIZING INDEX
    viewModel = ViewModelSearchScreen(context: context);

    /// GET DATA FROM FIRE STORE
    _search();

    /// Listening to events
    _eventController.stream.listen((event) {
      switch (event) {
        case EnumsSearchScreen.update:
          _update();
          break;
        case EnumsSearchScreen.search:
          _search();
          break;
      }
    });
  }

  _update() {
    _stateSink.add(Object);
  }

  _search() async {
    viewModel.isLoading = true;
    _update();
    try {
      viewModel.foodSnapshot =
          await FirebaseFirestore.instance.collection('food').get();
    } catch (e) {
      _showErrorDialog(msg: e.toString());
    }
    viewModel.isLoading = false;
    _update();
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
