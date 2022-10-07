import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';
import 'package:ez_rappel/pages/app.dart';
import 'package:provider/provider.dart';

class AppContext {
  // edit groups
  static const unchanged = 0;
  static const uncommitedChanges = 1;
  static const commited = 2;
  static const markedForDelete = 3;

  Wordbase db = Wordbase();
  int editWordsStatus = unchanged;
  int editGroupsStatus = unchanged;

  close() {
    db.close();
  }
}

void main() async {
  runApp(Provider<AppContext>(
    create: (context) => AppContext(),
    child: const LanguageTupleApp(),
    dispose: (context, db) => db.close(),
  ));
}
