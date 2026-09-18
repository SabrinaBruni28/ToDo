import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/task.dart';

import 'dart:convert';
import 'dart:math';

class TaskStorage {
  static const String _key = 'data';

  // Gera um ID aleatório que ainda não existe
  static int generateId(List<Task> tasks) {
    final random = Random();

    int id;

    do {
      id = random.nextInt(1000000) + 1;
    } while (tasks.any((task) => task.id == id));

    return id;
  }

  // Carrega as tarefas salvas
  static Future<List<Task>> load() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(_key);

    if (data == null) return [];

    final List<dynamic> jsonList = jsonDecode(data);

    return jsonList.map((item) => Task.fromJson(item)).toList();
  }

  // Salva todas as tarefas
  static Future<void> save(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = tasks.map((task) => task.toJson()).toList();

    await prefs.setString(_key, jsonEncode(jsonList));
  }
}
