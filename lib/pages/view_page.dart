import 'package:todo/widgets/page_container.dart';
import 'package:todo/widgets/primary_button.dart';
import 'package:todo/services/task_storage.dart';
import 'package:todo/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  late Task task;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    task = ModalRoute.of(context)!.settings.arguments as Task;
  }

  // Muda para a tela de edição
  Future edit() async {
    final result = await Navigator.of(context)
        .pushNamed("/edit", arguments: task);

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
            // Titulo
            const Center(
              child: Text(
                "Detalhes da task",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 28),

            // Titulo da tarefa
            const Text(
              "Tarefa",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),

            const SizedBox(height: 6),

            // Titulo em si
            Text(
              task.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            // Descrição da tarefa
            const Text(
              "Descrição",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),

            const SizedBox(height: 6),

            // Descrição em si
            Text(
              task.description.isEmpty
                  ? "Nenhuma descrição informada."
                  : task.description,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 24),

            // Status da tarefa
            const Text(
              "Status",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),

            const SizedBox(height: 6),

            // Status em si
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

            // Botão de Editar
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
