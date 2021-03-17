import 'package:amplify_blog/models/Post.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  final Post post;

  PostScreen({this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(post.title),
        ),
        body: Container());
  }

  static void navigate(BuildContext context, Post post) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PostScreen(post: post)),
    );
  }
}
