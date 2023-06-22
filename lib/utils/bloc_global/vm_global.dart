import 'package:flutter/cupertino.dart';

class ViewModelGlobal {
  bool? isFirstAppStart;
  BuildContext buildContext;
  double? deviceHeight, deviceWidth;

  ViewModelGlobal({required this.buildContext});
}
