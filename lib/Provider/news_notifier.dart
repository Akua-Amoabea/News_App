import 'package:flutter/cupertino.dart';

class NewsNotifier with ChangeNotifier{
  List allNews = [];


  List<String> selectedList = [];

  void toggleSelectedSection(bool isSelected, String section) {
    if (isSelected) {

      selectedList.add(section);


      debugPrint('$selectedList');
    } else {

    selectedList.remove(section);


      debugPrint('$selectedList');
    }

    notifyListeners();
  }

  void clearNews() {
    allNews.clear();
    notifyListeners();
  }

}