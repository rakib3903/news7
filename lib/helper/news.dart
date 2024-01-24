import 'dart:convert';
import 'package:news7/models/article_model.dart';
import 'package:http/http.dart' as http;
class News{
  List<ArticleModel> news = [];
   Future<void> getNews() async {
    
    final response = await http.get(
        Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=150a48a9a8bf4566bde0145b16fffa3d")
      );
      var jsonData = json.decode(response.body);
      if(jsonData['status'] == "ok"  && jsonData['articles'] != null){
        jsonData["articles"].forEach((element){
          if(element['title'] != null && element['author'] != null &&
          element['description'] != null && element['url'] != null &&
          element['urlToImage'] != null && element['content'] != null){
            ArticleModel articleModel = ArticleModel(
              title : element["title"],
              author : element['author'],
              description : element['description'], 
              url : element['url'],
              urlToImage : element['urlToImage'],
              content : element['content']
            );
            news.add(articleModel);
          }
        });
      }
    }
}


class CategoryNewsClass{
  List<ArticleModel> news = [];
   Future<void> getNews(String category) async {
    
    final response = await http.get(
        Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=150a48a9a8bf4566bde0145b16fffa3d")
      );
      var jsonData = json.decode(response.body);
      if(jsonData['status'] == "ok"  && jsonData['articles'] != null){
        jsonData["articles"].forEach((element){
          if(element['title'] != null && element['author'] != null &&
          element['description'] != null && element['url'] != null &&
          element['urlToImage'] != null && element['content'] != null){
            ArticleModel articleModel = ArticleModel(
              title : element["title"],
              author : element['author'],
              description : element['description'], 
              url : element['url'],
              urlToImage : element['urlToImage'],
              content : element['content']
            );
            news.add(articleModel);
          }
        });
      }
    }
}

