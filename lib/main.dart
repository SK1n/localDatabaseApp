import 'package:anime_list_app/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
      },
    );
  }
}
