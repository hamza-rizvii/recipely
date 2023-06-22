import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewModelSearchScreen {
  BuildContext context;
  double emailPasswordBoxWidth = 0;
  double loginButtonWidth = 0;
  double socialButtonsWidth = 0;
  bool isLoading = false;
  QuerySnapshot? foodSnapshot;

  ViewModelSearchScreen({required this.context});
}
