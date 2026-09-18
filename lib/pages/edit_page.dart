import 'package:todo/widgets/page_container.dart';
import 'package:todo/widgets/task_form.dart';
import 'package:todo/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final newTaskCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  late Task task;

  //? O que essa função faz exatamente
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    task = ModalRoute.of(context)!.settings.arguments as Task;

    newTaskCtrl.text = task.title;
    descriptionCtrl.text = task.description;
  }

  @override
  void dispose() {
    newTaskCtrl.dispose();
    descriptionCtrl.dispose();
    super.dispose();
  }

  // Salva a edição e volta para view
  void save() {
    if (newTaskCtrl.text.trim().isEmpty) return;

    task.title = newTaskCtrl.text.trim();
    task.description = descriptionCtrl.text.trim();

    Navigator.pop(context, task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: const AppBarToDo(title: "Editar Tarefa"),

      body: PageContainer(
        child: TaskForm(
          titleController: newTaskCtrl,
          descriptionController: descriptionCtrl,

          title: "Editar task",
          buttonText: "Salvar alterações",
          buttonIcon: Icons.save,

          onPressed: save,
        ),
      ),
    );
  }
}
