import 'package:flutter/material.dart';
import 'package:youtube/screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Home.routeName: (context) => const Home(),
      },
      initialRoute: Home.routeName,
    );
  }
}
