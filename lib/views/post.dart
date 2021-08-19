import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Post extends StatefulWidget {
  final String imageUrl, title, content;
  Post({
    required this.imageUrl,
    required this.title,
    required this.content,
  });

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  Widget postContent(htmlContent) {
    return Html(
      data: htmlContent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(widget.imageUrl),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              postContent(widget.content),
            ],
          ),
        ),
      ),
    );
  }
}
