import 'package:flutter/material.dart';
import 'package:youtube/screens/home_bloc_screen.dart';
import 'package:youtube/screens/home_riverpod_screen.dart';
import 'package:youtube/screens/home_screen.dart';

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
        HomeBlocScreen.routeName: (context) => const HomeBlocScreen(),
        HomeRiverpodScreen.routeName: (context) => const HomeRiverpodScreen(),
      },
      home: const HomeScreen()
    );
  }
}
