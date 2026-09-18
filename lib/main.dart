import 'package:todo/pages/edit_page.dart';
import 'package:todo/pages/home_page.dart';
import 'package:todo/pages/view_page.dart';
import 'package:todo/pages/add_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      // Nome do sistema
      title: "ToDo",

      // Icone de debug desativado
      debugShowCheckedModeBanner: false,

      // Temas do visual
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.purple),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),

      // Home
      home: HomePage(),

      // Rotas
      routes: {
        "/add": (context) => AddPage(),
        "/edit": (context) => EditPage(),
        "/view": (context) => ViewPage(),
      },
    ),
  );
}
