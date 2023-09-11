import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube/my_app.dart';
import 'package:youtube/utils/isar_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initial database (optional)
  await IsarService().openDB();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
