import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/item.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.purple),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> items = [];
  var newTaskCtrl = TextEditingController();

  _HomePageState() {
    load();
  }

  void add() {
    if (newTaskCtrl.text.isEmpty) return;
    setState(() {
      items.add(Item(title: newTaskCtrl.text, done: false));
      newTaskCtrl.clear();
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
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      setState(() {
        items = result;
      });
    }
  }

  Future save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(items));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white, fontSize: 24),

          decoration: InputDecoration(
            labelText: "Nova Tarefa",
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: items.length,

        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: Key(item.title),
            background: Container(
              color: Colors.red.withValues(alpha: 0.8),
              child: Icon(Icons.delete),
            ),
            onDismissed: (direction) {
              remove(index);
            },
            child: CheckboxListTile(
              title: Text(item.title),

              value: item.done,
              onChanged: (value) {
                setState(() {
                  item.done = value ?? false;
                });
                save();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        backgroundColor: Colors.purpleAccent,
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
