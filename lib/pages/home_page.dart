import 'package:todo/models/category.dart';
import 'package:todo/services/category_storage.dart';
import 'package:todo/services/task_storage.dart';
import 'package:todo/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/widgets/opcoes_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];
  List<Category> categories = [];
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    // Carrega a lista no inicio
    load();
  }

  // Muda para a tela de adicionar tarefa
  void addTarefa() async {
    final task = await Navigator.of(context)
        .pushNamed("/addTarefa", arguments: selectedCategoryId);

    if (task is! Task) return;

    task.id = TaskStorage.generateId(tasks);

    setState(() {
      tasks.add(task);
    });

    save();
  }

  // Muda para a tela de adicionar tarefa
  void addCategory() async {
    final categoria = await Navigator.of(context).pushNamed("/addCategoria");

    if (categoria is! Category) return;

    categoria.id = CategoryStorage.generateId(categories);

    setState(() {
      categories.add(categoria);
    });

    save();
  }

  List<Task> get filteredTasks {
    if (selectedCategoryId == null) {
      return tasks;
    }

    return tasks
        .where((task) => task.categoryId == selectedCategoryId)
        .toList();
  }

  void deleteCategory(Category category) {
    setState(() {
      // Se a categoria excluída estava selecionada,
      // volta para todas as categorias
      if (selectedCategoryId == category.id) {
        selectedCategoryId = 0;
      }

      // Remove a categoria
      categories.remove(category);

      // As tarefas dessa categoria ficam sem categoria
      for (final task in tasks) {
        if (task.categoryId == category.id) {
          task.categoryId = 0;
        }
      }
    });

    save();
  }

  // Carrega a lista de um json de save
  Future load() async {
    final resultTasks = await TaskStorage.load();
    final resultCategories = await CategoryStorage.load();

    if (resultCategories.isEmpty) {
      resultCategories.add(Category(name: "Sem Categoria", id: 0));
    }

    setState(() {
      tasks = resultTasks;
      categories = resultCategories;
      selectedCategoryId = 0;
    });

    if (resultCategories.length == 1 &&
        resultCategories.first.name == "Sem Categoria") {
      await CategoryStorage.save(resultCategories);
    }
  }

  // Salva a lista em um json de save
  Future save() async {
    await TaskStorage.save(tasks);
    await CategoryStorage.save(categories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: const AppBarToDo(title: "To Do"),

      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryCard(index);
              },
            ),
          ),
          Expanded(
            child: filteredTasks.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      return _buildTaskCard(filteredTasks[index]);
                    },
                  ),
          ),
        ],
      ),

      // Botão de adicionar no canto da tela
      floatingActionButton: Container(
        height: 120,
        width: 120,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OpcoesButton(text: "Tarefa", icon: Icons.add, onPressed: addTarefa),
            OpcoesButton(
              text: "Categoria",
              icon: Icons.add,
              onPressed: addCategory,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(int index) {
    final category = categories[index];
    final isSelected = selectedCategoryId == category.id;

    final categoryWidget = GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedCategoryId = null;
          } else {
            selectedCategoryId = category.id;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.purple
              : Colors.purple.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.purple, width: 1.5),
        ),
        child: Center(
          child: Text(
            category.name,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.purple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    // "Sem Categoria" não pode ser arrastada
    if (category.id == 0) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: categoryWidget,
      );
    }

    // Outras categorias podem ser arrastadas para excluir
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Dismissible(
        key: ValueKey(category.id),
        direction: DismissDirection.up,

        background: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(Icons.delete, color: Colors.white),
        ),

        confirmDismiss: (direction) async {
          return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Excluir categoria"),
                content: Text('Deseja excluir a categoria "${category.name}"?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      "Excluir",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        },

        onDismissed: (direction) {
          deleteCategory(category);
        },

        child: categoryWidget,
      ),
    );
  }

  Widget _buildTaskCard(Task task) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: ValueKey(task.id),
        direction: DismissDirection.endToStart,

        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.delete, color: Colors.white),
        ),

        onDismissed: (direction) {
          setState(() {
            tasks.remove(task);
          });

          save();
        },

        child: Card(
          elevation: 2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: task.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),

            onTap: () async {
              final result = await Navigator.of(context)
                  .pushNamed("/viewTarefa", arguments: task);

              if (result is Task) {
                setState(() {
                  final index = tasks.indexWhere((item) => item.id == task.id);

                  if (index != -1) {
                    tasks[index] = result;
                  }
                });

                save();
              }
            },

            trailing: Transform.scale(
              scale: 1.7,
              child: Checkbox(
                value: task.done,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                onChanged: (value) {
                  setState(() {
                    task.done = value ?? false;
                  });

                  save();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget para tela sem tarefas
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            // Icone
            Icon(
              size: 80,
              Icons.checklist,
              color: Colors.purple.withValues(alpha: 0.5),
            ),

            const SizedBox(height: 20),

            // Texto principal
            //? Porque não precisa de textalign
            //? Porque é const
            const Text(
              "Nenhuma task",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            // Texto explicativo
            Text(
              "Adicione uma tarefa para começar.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
