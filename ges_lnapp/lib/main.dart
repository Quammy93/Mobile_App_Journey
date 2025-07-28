// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'screens/home_screen.dart';
// import 'theme/app_theme.dart';

// void main() {
//   runApp(MyApp());
// }

// // ✅ Define the MyApp widget
// class MyApp extends StatelessWidget {
 
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'GES LN App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('GES LN App'),
//         ),
//         body: const Center(
//           child: Text('Hello GES!'),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GES Lesson Note Generator',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}