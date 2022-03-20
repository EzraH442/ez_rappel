import 'package:flutter/material.dart';

import 'package:luples_flutter/words/data/word_database_helper.dart';
import 'package:luples_flutter/words/data/entities/word_group.dart';
import 'package:luples_flutter/words/ui/components/routes.dart' as routes;

import 'package:luples_flutter/words/ui/components/display_wordgroups.dart'
    as components;

class PracticePage extends StatefulWidget {
  const PracticePage({Key? key}) : super(key: key);

  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final _db = WordDatabaseHelper.instance;
  final _selectedForPractice = <Wordgroup>{};

  ListTile _buildWordgroupRow(List<Wordgroup> wgs, int index) {
    final bool isSelected = _selectedForPractice.contains(wgs[index]);

    IconButton selectForPracticeIcon = IconButton(
        onPressed: () {
          setState(() {
            isSelected
                ? _selectedForPractice.remove(wgs[index])
                : _selectedForPractice.add(wgs[index]);
          });
        },
        icon: Icon(
          isSelected ? Icons.check_box : Icons.check_box_outline_blank,
          color: isSelected ? Colors.green : null,
          semanticLabel: isSelected ? "Remove Selection" : "Select",
        ));

    return ListTile(
      title: Text(wgs[index].name),
      trailing: selectForPracticeIcon,
    );
  }

  Column _buildWordgroupColumn(List<Wordgroup> results) {
    return Column(children: [
      const Text("Word Groups:"),
      ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: results.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (_, int i) => _buildWordgroupRow(results, i)),
      Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                routes.pushModifyWordgroups(context);
              },
              child: const Text("Edit Wordgroups"),
              style: const ButtonStyle(),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                if (_selectedForPractice.isNotEmpty) {
                  routes.pushFlashcards(context, _selectedForPractice);
                }
              },
              child: const Text("Start"),
              style: const ButtonStyle(),
            ),
          ),
        ],
      )
    ]);
  }

  Scaffold _displayScaffold(BuildContext context, WordDatabaseHelper db) =>
      Scaffold(
          body: components.wordgroupRowFutureBuilder(
              context, db, _buildWordgroupColumn));

  @override
  Widget build(BuildContext context) => _displayScaffold(context, _db);
}
