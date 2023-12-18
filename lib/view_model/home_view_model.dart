import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeViewModel with ChangeNotifier {
  // String slogan = "";
  List<String> sloganList = [];
  Future<List<String>> addSlogan(String newSlogan) async {
    Box<String> sloganBox = await Hive.openBox<String>("Slogan");
    sloganBox.add(newSlogan);
    sloganList = sloganBox.values.toList();
    notifyListeners();

    return sloganList;
  }

  Future<List<String>> editSlogan(int index, String updatedSlogan) async {
    Box<String> sloganBox = await Hive.openBox<String>("Slogan");
    sloganBox.putAt(index, updatedSlogan);
    sloganList = sloganBox.values.toList();
    notifyListeners();

    return sloganList;
  }

  Future<List<String>> getSloganList(int index, String updatedSlogan) async {
    Box<String> sloganBox = await Hive.openBox<String>("Slogan");
    sloganList = sloganBox.values.toList();
    notifyListeners();
    return sloganList;
  }
}
