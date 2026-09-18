import 'package:todo/widgets/page_container.dart';
import 'package:todo/widgets/task_form.dart';
import 'package:todo/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/category.dart';
import 'package:todo/services/category_storage.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final newTaskCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  late Task task;

  List<Category> categories = [];
  int? selectedCategoryId;

  bool initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (initialized) return;

    task = ModalRoute.of(context)!.settings.arguments as Task;

    newTaskCtrl.text = task.title;
    descriptionCtrl.text = task.description;

    selectedCategoryId = task.categoryId;

    initialized = true;

    loadCategories();
  }

  Future<void> loadCategories() async {
    final result = await CategoryStorage.load();

    if (!mounted) return;

    setState(() {
      categories = result;
    });
  }

  @override
  void dispose() {
    newTaskCtrl.dispose();
    descriptionCtrl.dispose();

    super.dispose();
  }

  // Salva a edição e volta para View
  void save() {
    if (newTaskCtrl.text.trim().isEmpty) return;

    task.title = newTaskCtrl.text.trim();
    task.description = descriptionCtrl.text.trim();

    if (selectedCategoryId != null) {
      task.categoryId = selectedCategoryId!;
    }

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

          selectedCategoryId: selectedCategoryId,

          onCategoryChanged: (categoryId) {
            setState(() {
              selectedCategoryId = categoryId;
            });
          },

          title: "Editar Tarefa",
          buttonText: "Salvar",
          buttonIcon: Icons.save,
          onPressed: save,
        ),
      ),
    );
  }
}
