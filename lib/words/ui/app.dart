import 'package:flutter/material.dart';
import 'home.dart';

class LanguageTupleApp extends StatelessWidget {
  const LanguageTupleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Language Tuples",
      home: Homepage(),
    );
  }
}
