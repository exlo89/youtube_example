import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube/models/todo.dart';

class IsarService {
  IsarService() {
    instance = openDB();
  }

  late Future<Isar> instance;

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return Isar.open(
        [
          TodoSchema,
        ],
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
