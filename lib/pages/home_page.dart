import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  void add() async {
    final item = await Navigator.of(context).pushNamed("/add");

    if (item == null) return;

    setState(() {
      items.add(item as Item);
    });

    save();
  }

  void remove(int index) {
    setState(() {
      items.removeAt(index);
    });

    save();
  }

  Future load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('data');

    if (data != null) {
      final Iterable decoded = jsonDecode(data);

      final List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();

      setState(() {
        items = result;
      });
    }
  }

  Future save() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('data', jsonEncode(items));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text(
          "To Do List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: items.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildTaskCard(index);
              },
            ),

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
    final item = items[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Dismissible(
        key: ValueKey(item.title),

        direction: DismissDirection.endToStart,

        background: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(16),
          ),

          alignment: Alignment.centerRight,

          padding: const EdgeInsets.only(right: 20),

          child: const Icon(Icons.delete, color: Colors.white),
        ),

        onDismissed: (direction) {
          remove(index);
        },

        child: Card(
          elevation: 2,
          margin: EdgeInsets.zero,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          child: CheckboxListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),

            activeColor: Colors.purple,

            title: Text(
              item.title,

              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,

                decoration: item.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,

                color: item.done ? Colors.grey : Colors.black87,
              ),
            ),

            value: item.done,

            onChanged: (value) {
              setState(() {
                item.done = value ?? false;
              });

              save();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Icon(
              Icons.checklist,
              size: 80,
              color: Colors.purple.withValues(alpha: 0.5),
            ),

            const SizedBox(height: 20),

            const Text(
              "Nenhuma tarefa",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

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
