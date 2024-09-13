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
              'id': (todos.lastOrNull?['id'] ?? 0) + 1,
              'title': result,
              'completed': false,
            });
          });
        },
        child: const Icon(Icons.add),
      ),
      body: TodoList(
        todos: todos,
        onTitleUpdate: (index, value) {
          setState(() {
            todos[index]['title'] = value;
          });
        },
        onChecked: (index, value) {
          setState(() {
            todos[index]['completed'] = value;
          });
        },
        onRemove: (index) {
          setState(() {
            todos.removeAt(index);
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
    required this.onTitleUpdate,
    required this.onChecked,
    required this.onRemove,
  });

  final List<Map<String, dynamic>> todos;
  final void Function(int index, String value) onTitleUpdate;
  final void Function(int index, bool? value) onChecked;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(child: Text('No todos yet!'));
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final item = todos[index];
        return Dismissible(
          key: ValueKey(item['id']),
          direction: DismissDirection.endToStart,
          background: const _DismissibleBackground(),
          confirmDismiss: (direction) => _confirmDismiss(context, direction),
          onDismissed: (_) => onRemove(index),
          child: ListTile(
            title: Text(item['title']),
            onTap: () async {
              final result = await Navigator.of(context).pushNamed(
                '/edit',
                arguments: item['title'],
              ) as String?;
              if (result == null) return;
              onTitleUpdate(index, result);
            },
            trailing: Checkbox(
              value: item['completed'],
              onChanged: (value) => onChecked(index, value),
            ),
          ),
        );
      },
    );
  }

  Future<bool?> _confirmDismiss(
    BuildContext context,
    DismissDirection direction,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Todo'),
          content: const Text(
            'Are you sure you want to delete this todo?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

class _DismissibleBackground extends StatelessWidget {
  const _DismissibleBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      alignment: Directionality.of(context) == TextDirection.rtl
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: const Padding(
        padding: EdgeInsets.only(right: 8),
        child: Icon(Icons.delete, color: Colors.white),
      ),
    );
  }
}
