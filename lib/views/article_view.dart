// ignore_for_file: avoid_unnecessary_containers, unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  
  final String blogUrl;

  
  const ArticleView({super.key, required this.blogUrl});

  @override
  // ignore: library_private_types_in_public_api
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title:  const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("News", style: TextStyle(color: Colors.black,)),
            Text("7", style: TextStyle(
              color: Colors.blue,
            )
            ),
          ]
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body : Container(
        child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);
          }),
        ),
      )
    );
  }
}