import 'package:flutter/material.dart';
import 'package:youtube/screens/home_bloc_screen.dart';
import 'package:youtube/screens/home_riverpod_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter State Management Sytems'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HomeBlocScreen.routeName);
              },
              child: const Text('Bloc'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HomeRiverpodScreen.routeName);
              },
              child: const Text('Riverpod'),
            ),
          ],
        ),
      ),
    );
  }
}
