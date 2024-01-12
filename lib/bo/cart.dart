import 'package:flutter/foundation.dart';

import 'article.dart';

class Cart with ChangeNotifier {
  final _listeArticles = <Article>[];

  List<Article> get listeArticles => _listeArticles;
  num getTotalPriceNum() => listeArticles.fold(0, (previousValue, element) => previousValue + (element.prix*100).toInt())/100;
  String getTotalPrice() => "${getTotalPriceNum()} €";

  void add(Article article) {
    _listeArticles.add(article);
    notifyListeners();
  }

  void remove(Article article) {
    if (_listeArticles.remove(article)) {
      notifyListeners();
    }
  }

  void removeAll() {
    _listeArticles.clear();
    notifyListeners();
  }
}