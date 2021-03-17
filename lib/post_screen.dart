import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  // TODO: Add a Post object
  // TODO: Create a Constructor for the Post object
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // TODO: Change the text to the post title
          title: Text("post.title"),
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

  // TODO: Add a post to navigate to
  static void navigate(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PostScreen()),
    );
  }
}
