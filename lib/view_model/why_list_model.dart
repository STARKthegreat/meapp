import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meapp/models/why_list_adapter.dart';

class WhyListViewModel with ChangeNotifier {
  List<WhyList> whyList = [];
  Future<bool> addAndSaveToWhyList({
    required String description,
    required String title,
  }) async {
    Box<WhyList> mylist = await Hive.openBox("Why");
    mylist.add(WhyList(title: title, description: description));
    whyList = mylist.values.toList();

    if (whyList.isEmpty) {
      notifyListeners();
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<List<WhyList>> getWhyList() async {
    Box<WhyList> mylist = await Hive.openBox("Why");
    whyList = mylist.values.toList();
    notifyListeners();
    return whyList;
  }
}
