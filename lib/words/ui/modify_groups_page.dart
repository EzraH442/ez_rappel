import 'package:flutter/material.dart';

import 'package:luples_flutter/words/data/word_database_helper.dart';
import 'package:luples_flutter/words/data/entities/word_group.dart';

class ModifyWordgroupPage extends StatefulWidget {
  const ModifyWordgroupPage({Key? key}) : super(key: key);

  @override
  _ModifyWordgroupPageState createState() => _ModifyWordgroupPageState();
}

class _ModifyWordgroupPageState extends State<ModifyWordgroupPage> {
  final _selectedForDelete = <WordGroup>{};

  final _nameController = TextEditingController();
  final _langOneController = TextEditingController();
  final _langTwoController = TextEditingController();

  final _db = WordDatabaseHelper.instance;

  WordGroup _tempWordGroup = const WordGroup(
      id: -1, name: "", languageOne: "", languageTwo: "", dateCreated: "");

  IconButton _markForDeletionIcon(List<WordGroup> wgs, int index) {
    final bool isMarkedForDeletion = _selectedForDelete.contains(wgs[index]);
    return IconButton(
        onPressed: () {
          setState(() {
            isMarkedForDeletion
                ? _selectedForDelete.remove(wgs[index])
                : _selectedForDelete.add(wgs[index]);
          });
        },
        icon: Icon(
          isMarkedForDeletion
              ? Icons.delete_forever
              : Icons.delete_forever_outlined,
          color: isMarkedForDeletion ? Colors.red : null,
          semanticLabel:
              isMarkedForDeletion ? "Delete Wordgroup Forever" : "Undo",
        ));
  }

  ListTile _addWordgroupRow() {
    return ListTile(
        leading: Row(children: [
          TextField(controller: _nameController),
          TextField(controller: _langOneController),
          TextField(controller: _langTwoController),
        ]),
        trailing: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.cancel,
                  semanticLabel: "cancel",
                )),
            IconButton(
                onPressed: () {
                  _tempWordGroup = WordGroup(
                      id: -1,
                      name: _nameController.value.text,
                      languageOne: _langOneController.value.text,
                      languageTwo: _langTwoController.value.text,
                      dateCreated: DateTime.now().toIso8601String());
                },
                icon: const Icon(
                  Icons.done,
                  semanticLabel: "Add",
                ))
          ],
        ));
  }

  Column _buildWordgroupColumn(List<dynamic> dbRes) {
    List<WordGroup> results = dbRes.cast<WordGroup>();

    return Column(children: [
      const Text("Word Groups:"),
      ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: results.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (_, int i) => _buildWordgroupRow(results, i)),
      _addWordgroupRow(),
      Row(
        children: [
          TextButton(onPressed: () {}, child: const Text("Cancel")),
          TextButton(onPressed: () {}, child: const Text("Confirm Changes")),
        ],
      )
    ]);
  }

  ListTile _buildWordgroupRow(List<WordGroup> wgs, int index) {
    return ListTile(
      title: Text(wgs[index].name),
      trailing: _markForDeletionIcon(wgs, index),
    );
  }

  Scaffold _displayScaffold(BuildContext context, WordDatabaseHelper db) =>
      Scaffold(
        body: FutureBuilder<List>(
          future: db.queryAllWordGroups(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? _buildWordgroupColumn(snapshot.data!)
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      );

  @override
  void dispose() {
    _nameController.dispose();
    _langOneController.dispose();
    _langTwoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _displayScaffold(context, _db);
}
