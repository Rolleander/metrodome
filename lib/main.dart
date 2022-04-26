import 'package:flutter/material.dart';
import 'package:metrodome/pages/root_page.dart';

void main() {
  runApp(const MetrodomeApp());
}

class MetrodomeApp extends StatelessWidget {
  const MetrodomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'metrodome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RootPage(),
    );
  }
}
