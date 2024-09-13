import 'package:flutter/material.dart';
import 'package:todo_no_deps/pages/create_todo.dart';
import 'package:todo_no_deps/pages/edit_todo.dart';
import 'package:todo_no_deps/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        final path = settings.name;
        if (path == null) {
          throw StateError('No path provided');
        }

        return MaterialPageRoute(
          builder: (context) {
            final args = settings.arguments;
            return switch (path) {
              '/' => const HomePage(),
              '/create' => const CreateTodoPage(),
              '/edit' => EditTodoPage(initial: args as String),
              _ => Scaffold(
                  body: Center(
                    child: Column(
                      children: [
                        Text('No route defined for $path'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamedAndRemoveUntil(
                            '/',
                            (_) => false,
                          ),
                          child: const Text('Go back'),
                        ),
                      ],
                    ),
                  ),
                )
            };
          },
        );
      },
      // routes: {
      //   '/': (context) => const HomePage(),
      //   '/create': (context) => const CreateTodoPage(),
      //   '/edit': (context) {
      //     final initial = ModalRoute.of(context)?.settings.arguments as String?;
      //     if (initial == null) {
      //       throw StateError('No initial value provided');
      //     }
      //     return EditTodoPage(initial: initial);
      //   },
      // },
    );
  }
}
