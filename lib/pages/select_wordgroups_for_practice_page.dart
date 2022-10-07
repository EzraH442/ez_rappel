import 'package:ez_rappel/main.dart';
import 'package:ez_rappel/storage/tables.dart';
import 'package:ez_rappel/ui/components/display_wordgroups.dart';
import 'package:flutter/material.dart';

import 'package:ez_rappel/ui/routes/primary_routes.dart' as routes;
import 'package:provider/provider.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({Key? key}) : super(key: key);

  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final _selectedForPractice = <Tag>{};

  ListTile _buildTagRow(List<Tag> tags, int index) {
    final bool isSelected = _selectedForPractice.contains(tags[index]);

    IconButton selectForPracticeIcon = IconButton(
        onPressed: () {
          setState(() {
            isSelected
                ? _selectedForPractice.remove(tags[index])
                : _selectedForPractice.add(tags[index]);
          });
        },
        icon: Icon(
          isSelected ? Icons.check_box : Icons.check_box_outline_blank,
          color: isSelected ? Colors.green : null,
          semanticLabel: isSelected ? "Remove Selection" : "Select",
        ));

    return ListTile(
      title: Text(tags[index].name),
      trailing: selectForPracticeIcon,
    );
  }

  Column _buildTagColumn(List<Tag> results) {
    return Column(children: [
      const Text("Word Groups:"),
      ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: results.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (_, int i) => _buildTagRow(results, i)),
      Row(
        children: [
          TextButton(
            onPressed: () {
              if (_selectedForPractice.isNotEmpty) {
                routes.pushFlashcards(context, _selectedForPractice);
              }
            },
            child: const Text("Start Flashcards"),
            style: const ButtonStyle(),
          ),
          TextButton(
            onPressed: () {
              if (_selectedForPractice.isNotEmpty) {
                routes.pushTypingPractice(context, _selectedForPractice);
              }
            },
            child: const Text("Start Typing Practice"),
            style: const ButtonStyle(),
          ),
        ],
      )
    ]);
  }

  Scaffold _displayScaffold(BuildContext context) {
    final db = context.read<AppContext>().db;
    return Scaffold(
      appBar: AppBar(title: const Text("Practice Words")),
      body: rowFutureBuilder(context, db.allTags, _buildTagColumn),
    );
  }

  @override
  Widget build(BuildContext context) => _displayScaffold(context);
}
