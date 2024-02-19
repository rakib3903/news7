// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:news7/helper/data.dart';
import 'package:news7/helper/news.dart';
import 'package:news7/models/article_model.dart';
import 'package:news7/models/category_model.dart';
import 'package:news7/views/article_view.dart';
import 'package:news7/views/category_news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<ArticleModel>articles = [];
  bool _loading = true;
  @override
  void initState(){
    super.initState();
    categories = getCategories();
    getNews();
  }
  
  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
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
              color: Colors.white70)
            ),
          ]
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: const CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return CategoryTitle(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  },
                )
              ),
              ///Blog list
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
          ),
        ),
       ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final imageUrl, categoryName;
  const CategoryTitle({super.key, this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            category: categoryName.toLowerCase()
            )
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(right:15),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child:Image.network(imageUrl, width: 120, height: 60, fit : BoxFit.cover,),
            ),
            Container(
              alignment: Alignment.center,
              width:120, 
              height: 60,
              color: Colors.black26,
              child: Text(categoryName, style :const TextStyle(color : Colors.white)),
            )
          ],
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




