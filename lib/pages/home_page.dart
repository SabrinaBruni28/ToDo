import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    // Carrega a lista no inicio
    load();
  }

  // Muda para a tela de adicionar tarefa
  void add() async {
    final task = await Navigator.of(context).pushNamed("/add");

    if (task == null) return;

    setState(() {
      tasks.add(task as Task);
    });

    save();
  }

  // Exclui uma tarefa
  void remove(int index) {
    setState(() {
      tasks.removeAt(index);
    });

    save();
  }

  // Carrega a lista de um json de save
  Future load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('data');

    if (data != null) {
      final Iterable decoded = jsonDecode(data);

      final List<Task> result = decoded.map((x) => Task.fromJson(x)).toList();

      setState(() {
        tasks = result;
      });
    }
  }

  // Salva a lista em um json de save
  Future save() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('data', jsonEncode(tasks));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        // Titulo
        title: const Text(
          "To Do List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        // Configuração
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),

      body: tasks.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return _buildTaskCard(index);
              },
            ),

      // Botão de adicionar no canto da tela
      floatingActionButton: FloatingActionButton.extended(
        onPressed: add,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,

        icon: const Icon(Icons.add),

        label: const Text(
          "Adicionar",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTaskCard(int index) {
    final task = tasks[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Dismissible(
        key: ValueKey(task.title),
        direction: DismissDirection.endToStart,

        // Background
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),

          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(16),
          ),

          child: const Icon(Icons.delete, color: Colors.white),
        ),

        // Ação ao deslizar
        onDismissed: (direction) {
          remove(index);
        },

        child: Card(
          elevation: 2,
          margin: EdgeInsets.zero,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          child: ListTile(
            // Titulo da tarefa
            title: Text(
              task.title,

              // Estilo do texto
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: task.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),

            // Ação ao clicar
            onTap: () async {
              final result = await Navigator.of(context)
                  .pushNamed("/view", arguments: task);

              if (result is Task) {
                setState(() {
                  tasks[index] = result;
                });

                save();
              }
            },

            // Icone de check
            trailing: Transform.scale(
              scale: 1.7,
              child: Checkbox(
                value: task.done,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),

                // Ação
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
              "Adicione uma task para começar.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
