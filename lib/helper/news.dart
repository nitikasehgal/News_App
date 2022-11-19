import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:news_app/models/news_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<NewsModel> news = [];
  Future<void> getdata() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=ff7c89271bdd4e74977fcb96f542e640 ';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          NewsModel newsModel = NewsModel(
            title: element['title'],
            author: element['author'],
            desc: element['description'],
            imgUrl: element['urlToImage'],
            Url: element['url'],
            content: element['content'],
          );
          news.add(newsModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<NewsModel> news = [];
  Future<void> getCategorydata(String type) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&category=${type}&apiKey=ff7c89271bdd4e74977fcb96f542e640 ';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          NewsModel newsModel = NewsModel(
            title: element['title'],
            author: element['author'],
            desc: element['description'],
            imgUrl: element['urlToImage'],
            Url: element['url'],
            content: element['content'],
          );
          news.add(newsModel);
        }
      });
    }
  }
}
