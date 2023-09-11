import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:youtube/models/todo.dart';
import 'package:youtube/utils/isar_service.dart';

class HomeIsarScreen extends StatefulWidget {
  static const String routeName = 'home-isar';

  const HomeIsarScreen({super.key});

  @override
  State<HomeIsarScreen> createState() => _HomeIsarScreenState();
}

class _HomeIsarScreenState extends State<HomeIsarScreen> {
  String todo = "";

  Future<List<Todo>> getTodo() async {
    Isar isar = await IsarService().instance;
    return Future.value(isar.todos.where().findAll());
  }

  Future<void> addTodo(String todo) async {
    Isar isar = await IsarService().instance;
    await isar.writeTxn(() async {
      isar.todos.put(Todo(todo: todo));
    });
  }

  Future<void> setTodo(int id, bool done) async {
    Isar isar = await IsarService().instance;
    await isar.writeTxn(() async {
      final todo = await isar.todos.get(id);

      if (todo != null) {
        todo.done = done;
        isar.todos.put(todo);
      }
    });
  }

  Future<void> removeTodo(int id) async {
    Isar isar = await IsarService().instance;
    await isar.writeTxn(() async {
      isar.todos.delete(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isar'),
      ),
      body: Center(
        child: FutureBuilder(
          future: getTodo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }
            if (snapshot.data!.isNotEmpty) {
              return Column(
                children: List.generate(
                  snapshot.data!.length,
                  (index) {
                    Todo todo = snapshot.data![index];
                    return ListTile(
                      leading: Checkbox(
                        onChanged: (value) {
                          setTodo(todo.id!, value ?? false);
                          setState(() {});
                        },
                        value: todo.done ?? false,
                      ),
                      title: Text(todo.todo ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await removeTodo(todo.id!);
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Was möchtest du tun?',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        todo = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('zurück'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await addTodo(todo);
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: const Text('hinzufügen'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
