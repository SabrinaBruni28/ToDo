import 'package:flutter/material.dart';

class OpcoesButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const OpcoesButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,

      child: FloatingActionButton.extended(
        onPressed: onPressed,
        heroTag: null,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,

        icon: Icon(icon),

        label: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
