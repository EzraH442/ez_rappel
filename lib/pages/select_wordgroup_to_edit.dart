import 'package:flutter/material.dart';

import 'package:ez_rappel/ui/routes/primary_routes.dart' as routes;
import 'package:ez_rappel/page_components.dart';
import 'package:ez_rappel/database_utils.dart';

class _NameIdPair {
  final String name;
  final int id;

  _NameIdPair({required this.id, required this.name});

  @override
  get hashCode {
    return id.hashCode;
  }

  @override
  bool operator ==(Object o) {
    return (o is _NameIdPair) && o.id == id;
  }
}

class ModifyWordsPage extends StatefulWidget {
  const ModifyWordsPage({Key? key}) : super(key: key);

  @override
  _ModifyWordsPageState createState() => _ModifyWordsPageState();
}

class _ModifyWordsPageState extends State<ModifyWordsPage> {
  final _db = WordDatabaseHelper.instance;
  _NameIdPair? _value;

  void onChanged(value) {
    setState(() {
      _value = value;
    });
  }

  void onButtonPressed() {
    Navigator.pop(context);
    routes.pushModifyWordpairsOfGroup(context, _value!.id);
  }

  DropdownButton _buildColumn(List<Wordgroup> wgs) {
    return DropdownButton(
      items: wgs
          .map((e) => DropdownMenuItem(
                child: Text(e.name),
                value: _NameIdPair(id: e.id, name: e.name),
              ))
          .toList(),
      onChanged: onChanged,
      value: _value,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDisabled = (_value == null);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select wordgroup to edit"),
      ),
      body: Card(
          child: Column(children: [
        rowFutureBuilder<Wordgroup>(
            context, _db.queryAllWordgroups(), _buildColumn),
        isDisabled
            ? const Text("Please select a wordgroup")
            : TextButton(onPressed: onButtonPressed, child: const Text("Edit"))
      ])),
    );
  }
}
