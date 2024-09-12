import 'package:flutter/material.dart';
import 'package:todo_no_deps/pages/create_todo.dart';
import 'package:todo_no_deps/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const HomePage(),
        '/create': (context) => const CreateTodoPage(),
      },
    );
  }
}
