import 'package:flutter/material.dart';

import 'package:ez_rappel/database_utils.dart';

class ModifyWordsPage extends StatefulWidget {
  const ModifyWordsPage({Key? key}) : super(key: key);

  @override
  _ModifyWordsPageState createState() => _ModifyWordsPageState();
}

class _ModifyWordsPageState extends State<ModifyWordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(onPressed: _test, child: const Text('test'))
        ],
      )),
    );
  }

  _test() async {
    final db = WordDatabaseHelper.instance;
    const test = Wordgroup(
        id: 0,
        name: "a group name",
        languageOne: "eng",
        languageTwo: "fre",
        dateCreated: "today!");

    int id = await db.insertWordgroup(test);
  }
}
