import 'package:flutter/material.dart';
import 'package:vockify/src/models/home_item.dart';

class BarModel extends ChangeNotifier {
  HomeItem currentItem = HomeItem.start;

  void setCurrentItem(HomeItem item) {
    currentItem = item;
    notifyListeners();
  }
}
