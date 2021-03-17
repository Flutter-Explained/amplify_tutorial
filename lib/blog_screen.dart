import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_blog/models/Blog.dart';
import 'package:amplify_blog/models/ModelProvider.dart';
import 'package:amplify_blog/post_screen.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List<Blog> blogs = [];
  String blogTitle;
  String postTitle;
  StreamSubscription _subscription;
  bool _loggedIn = false;

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    _subscription = Amplify.DataStore.observe(Blog.classType)
        .listen((SubscriptionEvent event) {
      print(event.eventType);
      switch (event.eventType) {
        case EventType.create:
          blogs.add(event.item);
          break;
        case EventType.update:
          var index = blogs.indexOf(event.item);
          blogs[index] = event.item;
          break;
        case EventType.delete:
          blogs.removeWhere((element) => element.id == event.item.id);
          break;
      }
      setState(() {});
    });
    initBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Our Blogs")),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    indent: 16,
                    endIndent: 16,
                    color: Colors.black,
                  ),
                  itemCount: blogs.length,
                  itemBuilder: (item, index) {
                    return ListTile(
                      title: Text(blogs[index].name),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () async {
                          Amplify.DataStore.delete(blogs[index]);
                        },
                      ),
                      onTap: () async {
                        var posts = await Amplify.DataStore.query(
                          Post.classType,
                          where: Post.BLOG.eq(blogs[index].id),
                        );
                        PostScreen.navigate(context, posts.first);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: _loggedIn
                        ? Column(children: [
                            Text(
                              "Add a new Blog Post",
                              style: TextStyle(fontSize: 22),
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Blog Title"),
                              onChanged: (value) {
                                blogTitle = value;
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Post Title"),
                              onChanged: (value) {
                                postTitle = value;
                              },
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              child: Text("Add Blog"),
                              onPressed: () async {
                                Blog newBlog = Blog(name: blogTitle);
                                var post = Post(
                                  title: postTitle,
                                  status: PostStatus.DRAFT,
                                  blog: newBlog,
                                );
                                await Amplify.DataStore.save(newBlog);
                                await Amplify.DataStore.save(post);
                              },
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await Amplify.Auth.signOut();
                                setState(() {
                                  _loggedIn = false;
                                });
                              },
                              child: Text("Logout"),
                            )
                          ])
                        : Column(
                            children: [
                              Text(
                                "Please log into your account to add new blogs",
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () async {
                                  SignInResult res = await Amplify.Auth.signIn(
                                    username: "flutterexp@gmail.com",
                                    password: "12345678",
                                  );

                                  setState(() {
                                    _loggedIn = res.isSignedIn;
                                  });
                                },
                                child: Text("Log in"),
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    SignInResult res =
                                        await Amplify.Auth.signIn(
                                      username: "flutterexp@gmail.com",
                                      password: "12345678",
                                    );
                                    setState(() {
                                      _loggedIn = res.isSignedIn;
                                    });
                                  },
                                  child: Text("Register"))
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> initBlogs() async {
    blogs = await Amplify.DataStore.query(Blog.classType);
  }
}
