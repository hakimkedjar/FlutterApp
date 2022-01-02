import 'package:flutter/foundation.dart';
import 'package:cash_manager/models/article.dart';

class Cart extends ChangeNotifier {
  final List<Article> _articles = [];
  int _total = 0;

  List<Article> get articles => _articles;
  int get total => _total;

  void add(Article article) {
    _articles.add(article);
    _total += article.price;
    notifyListeners();
  }

  void remove(Article article) {
    _articles.remove(article);
    _total -= article.price;
    notifyListeners();
  }
}
