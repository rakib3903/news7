import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/models/category_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<CategoryModel> categories = [];
  @override
  void initState(){
    super.initState();
    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Flutter", style: TextStyle(color: Colors.black,)),
            Text("News", style: TextStyle(
              color: Colors.blue,
            )
            ),
          ]
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: <Widget>[
            // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
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
            )
          ]
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
    // ignore: avoid_unnecessary_containers
    return  Container(
      child: Stack(
        children: <Widget>[
          Image.network(imageUrl, width: 120, height: 60),
        ],
      ),
    );
  }
}
