import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  StreamSubscription _subscription;

  // TODO: Add a List of Blogs
  List _blogs = [];
  String _blogTitle;
  String _postTitle;

  bool _loggedIn = false;
  bool _registered = false;

  String _email = "flutterexp@gmail.com";
  String _password = "12345678";
  String _confirmationNumber = "";

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    try {
      Amplify.Auth.signOut();
    } catch (e) {}

    // TODO: Add a subscription and observe the DataStore
/*    _subscription = Amplify.DataStore.observe(Blog.classType)
        .listen((SubscriptionEvent event) {
      print(event.eventType);
      switch (event.eventType) {
        case EventType.create:
          _blogs.add(event.item);
          break;
        case EventType.update:
          var index = _blogs.indexOf(event.item);
          _blogs[index] = event.item;
          break;
        case EventType.delete:
          _blogs.removeWhere((element) => element.id == event.item.id);
          break;
      }
      setState(() {});
    });*/
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
                  itemCount: _blogs.length,
                  itemBuilder: (item, index) {
                    return ListTile(
                      title: Text(_blogs[index].name),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () async {
                          // TODO: Delete the blog from the DataStore
                        },
                      ),
                      onTap: () async {
                        // TODO: Query for the Posts and navigate to it
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
                                _blogTitle = value;
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Post Title"),
                              onChanged: (value) {
                                _postTitle = value;
                              },
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              child: Text("Add Blog"),
                              onPressed: () async {
                                // TODO: Create a new Blog
                                // TODO: Create a new Post
                                // TODO: Save Blog and Post inside of the DataStore
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Please log into your account to add new blogs",
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: _login,
                                child: Text("Log in"),
                              ),
                              Divider(
                                color: Colors.black,
                                indent: 8,
                                endIndent: 8,
                              ),
                              ElevatedButton(
                                onPressed: _registerAccount,
                                child: Text("Register"),
                              ),
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _confirmationNumber = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Confirmation Code",
                                ),
                              ),
                              ElevatedButton(
                                onPressed: _registered &&
                                        _confirmationNumber.isNotEmpty
                                    ? _confirmSignUp
                                    : null,
                                child: Text("Confirmation"),
                              )
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _login() async {
    SignInResult res = await Amplify.Auth.signIn(
      username: _email,
      password: _password,
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Logged In successful"),
    ));

    setState(() {
      _loggedIn = res.isSignedIn;
    });
  }

  void _registerAccount() async {
    await Amplify.Auth.signUp(
      username: _email,
      password: _password,
      options: CognitoSignUpOptions(
        userAttributes: {"email": _email},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Registration complete"),
    ));
    setState(() {
      _registered = true;
    });
  }

  _confirmSignUp() async {
    await Amplify.Auth.confirmSignUp(
      username: _email,
      confirmationCode: _confirmationNumber,
    );
    _login();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Confirmation complete"),
    ));
  }

  Future<void> initBlogs() async {
    // TODO: Initialize already written Blogs
  }
}
