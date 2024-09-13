import 'package:flutter/material.dart';
import 'package:todo_no_deps/widgets/create_or_edit_form.dart';

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({super.key, required this.initial});

  final String initial;

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController()..text = widget.initial;
    // Same as
    // controller = TextEditingController();
    // controller.text = widget.initial;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CreateOrEditPage(controller: controller, isEdit: true);
  }
}
