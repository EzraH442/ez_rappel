import 'package:flutter/material.dart';

class Flashcard extends StatelessWidget {
  final String word;
  final void Function() onTap;

  const Flashcard({Key? key, required this.word, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Card(
          child: TextButton(
              child: Text(
                word,
                textAlign: TextAlign.center,
              ),
              onPressed: onTap)),
    );
  }
}
