import 'package:amplify_tutorial/blog_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(MyApp());
}

Future<void> configureAmplify() async {
  // TODO: Add AmplifyDataStore
  // TODO: Add AmplifyAuthCognito
  // TODO Add DataStore and AuthCognito to addPlugins
  // TODO: Configure Amplify
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlogScreen(),
    );
  }
}
