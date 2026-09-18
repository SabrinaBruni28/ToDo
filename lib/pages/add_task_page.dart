import 'package:todo/services/category_storage.dart';
import 'package:todo/widgets/page_container.dart';
import 'package:todo/widgets/task_form.dart';
import 'package:todo/widgets/app_bar.dart';
import 'package:todo/models/category.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final newTaskCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  List<Category> categories = [];
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();

    loadCategories();
  }

  @override
  void dispose() {
    newTaskCtrl.dispose();
    descriptionCtrl.dispose();

    super.dispose();
  }

  Future<void> loadCategories() async {
    final resultCategories = await CategoryStorage.load();
    setState(() {
      categories = resultCategories;
      selectedCategoryId = ModalRoute.of(context)!.settings.arguments as int;
    });
  }

  void addTask() {
    if (newTaskCtrl.text.trim().isEmpty) return;

    if (selectedCategoryId == null) return;

    final task = Task(
      title: newTaskCtrl.text.trim(),
      description: descriptionCtrl.text.trim(),
      done: false,
      categoryId: selectedCategoryId!,
    );

    Navigator.pop(context, task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: const AppBarToDo(title: "Nova Tarefa"),

      body: PageContainer(
        child: TaskForm(
          titleController: newTaskCtrl,
          descriptionController: descriptionCtrl,

          selectedCategoryId: selectedCategoryId,

          onCategoryChanged: (categoryId) {
            setState(() {
              selectedCategoryId = categoryId;
            });
          },

          title: "Adicionar Tarefa",
          buttonText: "Adicionar",
          buttonIcon: Icons.add,
          onPressed: addTask,
        ),
      ),
    );
  }
}
