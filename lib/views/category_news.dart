// ignore_for_file: avoid_unnecessary_containers, unused_field

import 'package:flutter/material.dart';
import 'package:news7/helper/news.dart';
import 'package:news7/models/article_model.dart';
import 'package:news7/views/article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  const CategoryNews({super.key, required this.category});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel>articles = [];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

   getCategoryNews() async{
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 174, 176),
        title:  const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("News", style: TextStyle(color: Colors.white,)),
            Text("7", style: TextStyle(
              color: Colors.white70,
            )
            ),
          ]
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:  _loading ? Center(
        child: Container(
          child: const CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          child : Column(
            children : <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    itemBuilder:(context, index){
                      return BlogTitle(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url,
                      );
                    },
                  ),
                ),
            ]  
          )
        ),
      ),
    );
  }
}

class BlogTitle extends StatelessWidget {
  

  final String imageUrl, title, desc, url;
  const BlogTitle({super.key, required this.imageUrl, required this.title,
                  required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
            blogUrl: url,
          )
        ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child:Column(
          children: <Widget>[
            Image.network(imageUrl),
            Text(
              title,
              style: const TextStyle(
                color:Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(desc, style: const TextStyle(color: Colors.black),)
          ],
        )
      ),
    );
  }
}
