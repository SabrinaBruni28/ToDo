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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        // Titulo
        title: const Text(
          "Visualizar Task",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        // Configuração
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,

        // Seta de voltar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, task);
          },
        ),
      ),

      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(28),

          // Caixa
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),

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
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
                    task.done
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
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
              SizedBox(
                height: 50,
                width: double.infinity,

                child: ElevatedButton.icon(
                  onPressed: edit,
                  icon: const Icon(Icons.edit),

                  label: const Text(
                    "Editar task",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  // Estilo do botão
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
