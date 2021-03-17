import 'package:amplify_blog/amplifyconfiguration.dart';
import 'package:amplify_blog/blog_screen.dart';
import 'package:amplify_blog/models/ModelProvider.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureAmplify();
  runApp(MyApp());
}

Future<void> configureAmplify() async {
  AmplifyDataStore dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  Amplify.addPlugins([dataStorePlugin]);

  try {
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException {
    print("Tried to reconfigure Amplify");
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlogScreen(),
    );
  }
}
