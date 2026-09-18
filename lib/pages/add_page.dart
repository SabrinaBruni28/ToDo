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

      appBar: AppBar(
        // Titulo
        title: const Text(
          "Nova Task",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        // Configuração
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
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
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              // Titulo
              const Text(
                "Adicionar task",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              // Descrição
              Text(
                "Digite os dados da nova task",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),

              const SizedBox(height: 24),

              // Entrada do Título da task
              TextFormField(
                controller: newTaskCtrl,
                keyboardType: TextInputType.text,

                decoration: InputDecoration(
                  labelText: "Task",
                  hintText: "Ex.: Estudar Flutter",

                  filled: true,
                  fillColor: Colors.grey[100],

                  prefixIcon: const Icon(Icons.edit, color: Colors.purple),

                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Entrada da Descrição da task
              TextFormField(
                maxLines: 4,
                controller: descriptionCtrl,
                keyboardType: TextInputType.multiline,

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
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Botão de confirmação
              SizedBox(
                height: 50,
                width: double.infinity,

                child: ElevatedButton.icon(
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

                  icon: const Icon(Icons.add),

                  label: const Text(
                    "Adicionar task",
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
