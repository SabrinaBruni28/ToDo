import 'package:flutter/material.dart';

class AppBarToDo extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const AppBarToDo({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,

      leading: onBack == null
          ? null
          : IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBack),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
