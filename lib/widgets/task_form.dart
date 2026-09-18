import 'package:flutter/material.dart';
import 'package:todo/widgets/primary_button.dart';

class TaskForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  final String title;
  final String buttonText;
  final IconData buttonIcon;

  final VoidCallback onPressed;

  const TaskForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.title,
    required this.buttonText,
    required this.buttonIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        // Título
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 24),

        // Tarefa
        TextFormField(
          controller: titleController,
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
          controller: descriptionController,
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

        const SizedBox(height: 24),

        // Botão
        PrimaryButton(text: buttonText, icon: buttonIcon, onPressed: onPressed),
      ],
    );
  }
}
