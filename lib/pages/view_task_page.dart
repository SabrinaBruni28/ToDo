import 'package:todo/widgets/page_container.dart';
import 'package:todo/widgets/primary_button.dart';
import 'package:todo/services/task_storage.dart';
import 'package:todo/services/category_storage.dart';
import 'package:todo/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/category.dart';

class ViewTaskPage extends StatefulWidget {
  const ViewTaskPage({super.key});

  @override
  State<ViewTaskPage> createState() => _ViewTaskPageState();
}

class _ViewTaskPageState extends State<ViewTaskPage> {
  late Task task;

  List<Category> categories = [];

  bool initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (initialized) return;

    task = ModalRoute.of(context)!.settings.arguments as Task;

    initialized = true;

    loadCategories();
  }

  // Carrega as categorias
  Future<void> loadCategories() async {
    final result = await CategoryStorage.load();

    if (!mounted) return;

    setState(() {
      categories = result;
    });
  }

  // Encontra o nome da categoria da tarefa
  String getCategoryName() {
    final category = categories.where(
      (category) => category.id == task.categoryId,
    );

    if (category.isEmpty) {
      return "Sem Categoria";
    }

    return category.first.name;
  }

  // Muda para a tela de edição
  Future<void> edit() async {
    final result = await Navigator.of(context)
        .pushNamed("/editTarefa", arguments: task);

    if (result is Task) {
      setState(() {
        task = result;
      });

      final tasks = await TaskStorage.load();

      final index = tasks.indexWhere((item) => item.id == task.id);

      if (index != -1) {
        tasks[index] = task;
        await TaskStorage.save(tasks);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBarToDo(
        title: "Visualizar Task",
        onBack: () {
          Navigator.pop(context, task);
        },
      ),

      body: PageContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Center(
              child: Text(
                "Detalhes da task",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 28),

            // Título da tarefa
            const Text(
              "Tarefa",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              task.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            // Descrição
            const Text(
              "Descrição",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              task.description.isEmpty
                  ? "Nenhuma descrição informada."
                  : task.description,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 24),

            // Categoria
            const Text(
              "Categoria",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),

            const SizedBox(height: 6),

            Text(getCategoryName(), style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 24),

            // Status
            const Text(
              "Status",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                Icon(
                  task.done ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: task.done ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  task.done ? "Concluída" : "Pendente",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Botão de editar
            PrimaryButton(
              text: "Editar task",
              icon: Icons.edit,
              onPressed: edit,
            ),
          ],
        ),
      ),
    );
  }
}
