import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ✅ Define the MyApp widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GES LN App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GES LN App'),
        ),
        body: const Center(
          child: Text('Hello GES!'),
        ),
      ),
    );
  }
}
