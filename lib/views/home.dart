import 'package:flutter/material.dart';
import 'package:wordpressblog/views/post.dart';
import 'package:wordpressblog/wp-api.dart';
import 'package:flutter_html/flutter_html.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wordpress Blog'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: FutureBuilder(
          future: fatchWpPosts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int? index) {
                  Map wppost = snapshot.data[index];
                  return PostTitle(
                    href: wppost['_links']['wp:featuredmedia'][0]['href'],
                    title:
                        wppost['title']['rendered'].replaceAll("&#8211;", ""),
                    desc: wppost['excerpt']['rendered'],
                    content: wppost['content']['rendered'],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class PostTitle extends StatefulWidget {
  final String href, title, desc, content;
  PostTitle({
    required this.href,
    required this.title,
    required this.desc,
    required this.content,
  });

  @override
  _PostTitleState createState() => _PostTitleState();
}

class _PostTitleState extends State<PostTitle> {
  var imageUrl = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Post(
                      imageUrl: imageUrl,
                      title: widget.title,
                      content: widget.content,
                    )));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: fatchWpPostImageUrl(widget.href),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    imageUrl = snapshot.data['guid']['rendered'];
                    return Image.network(snapshot.data['guid']['rendered']);
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Html(
              data: widget.desc,
              style: {
                "p": Style(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                ),
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
