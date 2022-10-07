import 'package:ez_rappel/main.dart';
import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';

import 'package:ez_rappel/ui/routes/primary_routes.dart' as routes;
import 'package:ez_rappel/page_components.dart';
import 'package:provider/provider.dart';

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

  Widget _buildColumn(List<Tag> tags) {
    return tags.isEmpty
        ? const Text("Create your first wordgroup before continuing")
        : DropdownButton(
            items: tags
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

    final db = context.read<AppContext>().db;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select wordgroup to edit"),
      ),
      body: Center(
        child: Card(
            child: Column(children: [
          rowFutureBuilder<Tag>(context, db.allTags, _buildColumn),
          isDisabled
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Please select a wordgroup"),
                )
              : TextButton(
                  onPressed: onButtonPressed, child: const Text("Edit"))
        ])),
      ),
    );
  }
}
