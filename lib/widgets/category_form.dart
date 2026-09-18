import 'package:todo/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class CategoryForm extends StatelessWidget {
  final TextEditingController titleController;

  final String title;
  final String buttonText;
  final IconData buttonIcon;

  final VoidCallback onPressed;

  const CategoryForm({
    super.key,
    required this.titleController,
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

        // Categoria
        TextFormField(
          controller: titleController,
          keyboardType: TextInputType.text,

          decoration: InputDecoration(
            labelText: "Categoria",
            hintText: "Ex.: Mercado",

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

        const SizedBox(height: 24),

        // Botão
        PrimaryButton(text: buttonText, icon: buttonIcon, onPressed: onPressed),
      ],
    );
  }
}
