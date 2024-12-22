import 'dart:convert';

import 'package:cloud_news/model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkProvider extends ChangeNotifier {
  List<ArticleModel> _bookmarks = [];

  List<ArticleModel> get bookmarks => _bookmarks;

  Future<void> loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedBookmarks = prefs.getString('bookmarks');
    if (savedBookmarks != null) {
      List<dynamic> bookmarksList = jsonDecode(savedBookmarks);
      _bookmarks =
          bookmarksList.map((item) => ArticleModel.fromJson(item)).toList();
    }
    notifyListeners();
  }

  Future<void> _saveBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> bookmarksList =
        _bookmarks.map((article) => article.toMap()).toList();
    prefs.setString('bookmarks', jsonEncode(bookmarksList));
  }

  Future<void> addBookmark(ArticleModel article) async {
    if (!_bookmarks.any((element) => element.url == article.url)) {
      _bookmarks.add(article);
      await _saveBookmarks();
      notifyListeners();
    }
  }

  Future<void> removeBookmark(String url) async {
    _bookmarks.removeWhere((article) => article.url == url);
    await _saveBookmarks();
    notifyListeners();
  }
}
