import 'package:todo/widgets/page_container.dart';
import 'package:todo/widgets/task_form.dart';
import 'package:todo/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

class AddPage extends StatelessWidget {
  final newTaskCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: const AppBarToDo(title: "Nova Tarefa"),

      body: PageContainer(
        child: TaskForm(
          titleController: newTaskCtrl,
          descriptionController: descriptionCtrl,

          title: "Adicionar task",
          buttonText: "Adicionar task",
          buttonIcon: Icons.add,

          onPressed: () {
            if (newTaskCtrl.text.trim().isEmpty) return;

            final task = Task(
              title: newTaskCtrl.text.trim(),
              description: descriptionCtrl.text.trim(),
              done: false,
            );

            newTaskCtrl.clear();
            descriptionCtrl.clear();

            Navigator.pop(context, task);
          },
        ),
      ),
    );
  }
}
