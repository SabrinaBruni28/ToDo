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

      appBar: AppBar(
        // Titulo
        title: const Text(
          "Editar Task",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        // Configuração
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
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
                blurRadius: 15,
                offset: const Offset(0, 5),
                color: Colors.black.withValues(alpha: 0.08),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              // Titulo
              const Text(
                "Editar task",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 24),

              // Entrada para editar título da tarefa
              TextFormField(
                controller: newTaskCtrl,
                keyboardType: TextInputType.text,

                decoration: InputDecoration(
                  labelText: "Task",
                  hintText: "Ex.: Estudar Flutter",

                  prefixIcon: const Icon(Icons.edit, color: Colors.purple),

                  filled: true,
                  fillColor: Colors.grey[100],

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Entrada para editar Descrição da tarefa
              TextFormField(
                controller: descriptionCtrl,
                keyboardType: TextInputType.multiline,
                maxLines: 4,

                decoration: InputDecoration(
                  labelText: "Descrição",
                  hintText: "Ex.: Estudar widgets, layouts e navegação.",

                  filled: true,
                  alignLabelWithHint: true,
                  fillColor: Colors.grey[100],

                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 75),
                    child: Icon(Icons.description, color: Colors.purple),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Botão de salvar
              SizedBox(
                height: 50,
                width: double.infinity,

                child: ElevatedButton.icon(
                  onPressed: save,

                  icon: const Icon(Icons.save),

                  label: const Text(
                    "Salvar alterações",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purple,

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
