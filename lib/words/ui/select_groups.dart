import 'package:ez_rappel/words/ui/components/display_wordgroups.dart';
import 'package:flutter/material.dart';

import 'package:ez_rappel/words/routes/primary_routes.dart' as routes;
import 'package:ez_rappel/database_utils.dart';

class ModifyWordsPage extends StatefulWidget {
  const ModifyWordsPage({Key? key}) : super(key: key);

  @override
  _ModifyWordsPageState createState() => _ModifyWordsPageState();
}

class _ModifyWordsPageState extends State<ModifyWordsPage> {
  final _db = WordDatabaseHelper.instance;
  int _selectedId = 0;

  void onChanged(id) {
    setState(() {
      _selectedId = id;
    });
  }

  void onButtonPressed() {
    Navigator.pop(context);
    routes.pushModifyWordpairsOfGroup(context, _selectedId);
  }

  DropdownButton buildColumn(List<Wordgroup> wgs) {
    return DropdownButton(
        items: wgs
            .map((e) => DropdownMenuItem(
                  child: Text(e.name),
                  value: e.id,
                ))
            .toList(),
        onChanged: onChanged);
  }

  @override
  Widget build(BuildContext context) {
    bool isDisabled = (_selectedId == 0);
    return Scaffold(
        body: Row(children: [
      rowFutureBuilder<Wordgroup>(
          context, _db.queryAllWordgroups(), buildColumn),
      isDisabled
          ? Text("Please select a wordgroup")
          : TextButton(onPressed: onButtonPressed, child: Text("edit"))
    ]));
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
