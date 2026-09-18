import 'package:flutter/material.dart';
import 'package:todo/models/category.dart';
import 'package:todo/services/category_storage.dart';
import 'package:todo/widgets/primary_button.dart';

class TaskForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  final String title;
  final String buttonText;
  final IconData buttonIcon;

  final int? selectedCategoryId;
  final ValueChanged<int?> onCategoryChanged;

  final VoidCallback onPressed;

  const TaskForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.title,
    required this.buttonText,
    required this.buttonIcon,
    required this.selectedCategoryId,
    required this.onCategoryChanged,
    required this.onPressed,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final result = await CategoryStorage.load();

    if (!mounted) return;

    setState(() {
      categories = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Título
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 24),

        // Tarefa
        TextFormField(
          controller: widget.titleController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "Tarefa",
            hintText: "Ex.: Estudar Flutter",
            filled: true,
            fillColor: Colors.grey[100],
            prefixIcon: const Icon(Icons.edit, color: Colors.purple),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.purple, width: 2),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Descrição
        TextFormField(
          controller: widget.descriptionController,
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: "Descrição",
            hintText: "Ex.: Estudar widgets, layouts e navegação.",
            filled: true,
            fillColor: Colors.grey[100],
            alignLabelWithHint: true,
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
              borderSide: const BorderSide(color: Colors.purple, width: 2),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Categoria
        DropdownButtonFormField<int>(
          initialValue: widget.selectedCategoryId,

          decoration: InputDecoration(
            labelText: "Categoria",
            filled: true,
            fillColor: Colors.grey[100],
            prefixIcon: const Icon(Icons.category, color: Colors.purple),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.purple, width: 2),
            ),
          ),

          items: categories.map((category) {
            return DropdownMenuItem<int>(
              value: category.id,
              child: Text(category.name),
            );
          }).toList(),

          onChanged: widget.onCategoryChanged,
        ),

        const SizedBox(height: 24),

        // Botão
        PrimaryButton(
          text: widget.buttonText,
          icon: widget.buttonIcon,
          onPressed: widget.onPressed,
        ),
      ],
    );
  }
}
