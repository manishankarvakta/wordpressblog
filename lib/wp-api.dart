import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> fatchWpPosts() async {
  final response = await http.get(
    Uri.parse("https://auroratec.net/index.php/wp-json/wp/v2/posts"),
    headers: {"Accept": "application/json"},
  );

  var convertedDatatoJson = jsonDecode(response.body);

  return convertedDatatoJson;
}

Future fatchWpPostImageUrl(url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {"Accept": "application/json"},
  );

  var convertedDatatoJson = jsonDecode(response.body);

  return convertedDatatoJson;
}
// class Post {
//   final int id;
//   final String title;
//   final String content;
//   final String excerpt;

//   Post({
//     required this.id,
//     required this.title,
//     required this.content,
//     required this.excerpt,
//   });

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       id: json['id'],
//       title: json['title'],
//       content: json['content'],
//       excerpt: json['excerpt'],
//     );
//   }
// }
