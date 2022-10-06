import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';
import 'package:ez_rappel/pages/app.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(Provider<Wordbase>(
    create: (context) => Wordbase(),
    child: const LanguageTupleApp(),
    dispose: (context, db) => db.close(),
  ));
}
