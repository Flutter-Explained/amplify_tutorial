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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              "https://i.ytimg.com/vi/IIHSiqZdXgk/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDllpGGYea8vwO8Hmf-2-I1VOuzdQ",
              fit: BoxFit.fill,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "Thanks once more for your Support!",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 8),
                    Text("We love to improve everyday...")
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  static void navigate(BuildContext context, Post post) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PostScreen(post: post)),
    );
  }
}
