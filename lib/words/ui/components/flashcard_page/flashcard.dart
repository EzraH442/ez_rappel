import 'package:flutter/material.dart';

class Flashcard extends StatelessWidget {
  final String word;
  final void Function() onTap;

  const Flashcard({Key? key, required this.word, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextButton(child: Text(word), onPressed: onTap),
    );
  }
}
