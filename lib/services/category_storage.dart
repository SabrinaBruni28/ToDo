import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/category.dart';

import 'dart:convert';
import 'dart:math';

class CategoryStorage {
  static const String _key = 'categories';

  // Gera um ID aleatório que ainda não existe
  static int generateId(List<Category> tasks) {
    final random = Random();

    int id;

    do {
      id = random.nextInt(1000000) + 1;
    } while (tasks.any((task) => task.id == id));

    return id;
  }

  // Carrega as tarefas salvas
  static Future<List<Category>> load() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(_key);

    if (data == null) return [];

    final List<dynamic> jsonList = jsonDecode(data);

    return jsonList.map((item) => Category.fromJson(item)).toList();
  }

  // Salva todas as tarefas
  static Future<void> save(List<Category> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = tasks.map((task) => task.toJson()).toList();

    await prefs.setString(_key, jsonEncode(jsonList));
  }
}
