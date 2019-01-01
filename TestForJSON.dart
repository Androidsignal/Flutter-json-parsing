import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:i_am_a_student/utils/TextStyle.dart';

class TestForJSON extends StatefulWidget {
  @override
  _TestForJSONState createState() => _TestForJSONState();
}

class _TestForJSONState extends State<TestForJSON> {
  String title = "", body = "";

  @override
  Future initState() {
    CallApi();

    super.initState();
  }

  CallApi() async {
    Map<String, dynamic> map = await fetchPost();
    title = map["title"];
    body = map["body"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            HeadlineText(
              text: title,
            ),
            SizedBox(
              height: 20.0,
            ),
            HeadlineText(
              text: body,
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchPost() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts/1');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      Map<String, dynamic> map = json.decode(response.body);

      return map;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
