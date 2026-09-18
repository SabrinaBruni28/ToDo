import 'package:todo/widgets/category_form.dart';
import 'package:todo/widgets/page_container.dart';
import 'package:todo/models/category.dart';
import 'package:todo/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AddCategoryPage extends StatelessWidget {
  final newCategoryCtrl = TextEditingController();

  AddCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: const AppBarToDo(title: "Nova Tarefa"),

      body: PageContainer(
        child: CategoryForm(
          titleController: newCategoryCtrl,

          title: "Adicionar task",
          buttonText: "Adicionar task",
          buttonIcon: Icons.add,

          onPressed: () {
            if (newCategoryCtrl.text.trim().isEmpty) return;

            final category = Category(name: newCategoryCtrl.text.trim());

            newCategoryCtrl.clear();

            Navigator.pop(context, category);
          },
        ),
      ),
    );
  }
}
