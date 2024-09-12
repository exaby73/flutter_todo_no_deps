import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await Navigator.of(context).pushNamed('/create') as String?;
          if (result == null || result.isEmpty) return;
          setState(() {
            todos.insert(0, {
              'title': result,
              'completed': false,
            });
          });
        },
        child: const Icon(Icons.add),
      ),
      body: TodoList(
        todos: todos,
        onChanged: (index, value) {
          setState(() {
            todos[index]['completed'] = value;
          });
        },
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.todos,
    required this.onChanged,
  });

  final List<Map<String, dynamic>> todos;
  final void Function(int index, bool? value) onChanged;

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(child: Text('No todos yet!'));
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final item = todos[index];
        return CheckboxListTile(
          title: Text(item['title']),
          value: item['completed'],
          onChanged: (value) => onChanged(index, value),
        );
      },
    );
  }
}
