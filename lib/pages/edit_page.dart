import 'package:flutter/material.dart';
import 'package:todo/models/item.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final newTaskCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  late Item item;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    item = ModalRoute.of(context)!.settings.arguments as Item;

    newTaskCtrl.text = item.title;
    descriptionCtrl.text = item.descricao;
  }

  @override
  void dispose() {
    newTaskCtrl.dispose();
    descriptionCtrl.dispose();
    super.dispose();
  }

  void save() {
    if (newTaskCtrl.text.trim().isEmpty) return;

    item.title = newTaskCtrl.text.trim();
    item.descricao = descriptionCtrl.text.trim();

    Navigator.pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text(
          "Editar Tarefa",
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
                "Editar tarefa",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 24),

              // Título
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

              const SizedBox(height: 16),

              // Descrição
              TextFormField(
                controller: descriptionCtrl,
                keyboardType: TextInputType.multiline,
                maxLines: 4,

                decoration: InputDecoration(
                  labelText: "Descrição",
                  hintText: "Ex.: Estudar widgets, layouts e navegação.",

                  alignLabelWithHint: true,

                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 75),
                    child: Icon(Icons.description, color: Colors.purple),
                  ),

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

              // Botão
              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
                  onPressed: save,

                  icon: const Icon(Icons.save),

                  label: const Text(
                    "Salvar alterações",
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
