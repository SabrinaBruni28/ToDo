import 'package:flutter/material.dart';
import 'package:todo/models/item.dart';

class AddPage extends StatelessWidget {
  final newTaskCtrl = TextEditingController();

  AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text(
          "Nova Tarefa",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(28),

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
              const Text(
                "Adicionar tarefa",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Digite o nome da nova tarefa",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),

              const SizedBox(height: 24),

              TextFormField(
                controller: newTaskCtrl,
                keyboardType: TextInputType.text,

                decoration: InputDecoration(
                  labelText: "Tarefa",
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

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
                  onPressed: () {
                    if (newTaskCtrl.text.trim().isEmpty) return;

                    final item = Item(
                      title: newTaskCtrl.text.trim(),
                      done: false,
                    );

                    newTaskCtrl.clear();

                    Navigator.pop(context, item);
                  },

                  icon: const Icon(Icons.add),

                  label: const Text(
                    "Adicionar tarefa",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    elevation: 2,
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
