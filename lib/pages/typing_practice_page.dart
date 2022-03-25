import 'package:flutter/material.dart';

import 'package:ez_rappel/database_utils.dart';
import 'package:ez_rappel/page_components.dart';

class TypingPracticePage extends StatefulWidget {
  final Set<Wordgroup> selectedWordGroups;

  const TypingPracticePage({Key? key, required this.selectedWordGroups})
      : super(key: key);

  @override
  _TypingPracticePageState createState() => _TypingPracticePageState();
}

class _TypingPracticePageState extends State<TypingPracticePage> {
  Future<List<Wordpair>> _getWordsFromMultipleGroups(
      Set<Wordgroup> wgs, WordDatabaseHelper db) async {
    List<Wordpair> ret = [];

    for (Wordgroup wg in wgs) {
      ret.addAll(await db.getWordsFromGroup(wg.id));
    }

    return ret;
  }

  @override
  Widget build(BuildContext context) {
    WordDatabaseHelper db = WordDatabaseHelper.instance;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Typing Practice"),
        ),
        body: rowFutureBuilder<Wordpair>(
            context,
            _getWordsFromMultipleGroups(widget.selectedWordGroups, db),
            ((wps) => TypePracticeWidget(wordpairs: wps))));
  }
}
