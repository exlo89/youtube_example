import 'package:isar/isar.dart';

part 'todo.g.dart';

@collection
class Todo {
  Id? id;
  String? todo;
  bool? done;
  DateTime? createdAt;

  Todo({
    this.id,
    required this.todo,
    this.done = false,
    this.createdAt,
  });

  @override
  String toString() {
    return 'id: $id, todo: $todo';
  }
}
