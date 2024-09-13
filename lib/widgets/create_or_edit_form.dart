import 'package:flutter/material.dart';

class CreateOrEditPage extends StatelessWidget {
  const CreateOrEditPage({
    super.key,
    required this.controller,
    this.isEdit = false,
  });

  final TextEditingController controller;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    final displayText = isEdit ? 'Edit' : 'Create';
    return Scaffold(
      appBar: AppBar(title: Text('$displayText Todo')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Title'),
              onFieldSubmitted: (_) => _popWithText(context),
            ),
            TextButton(
              onPressed: () => _popWithText(context),
              child: Text(displayText),
            ),
          ],
        ),
      ),
    );
  }

  void _popWithText(BuildContext context) {
    Navigator.of(context).pop(controller.text);
  }
}
