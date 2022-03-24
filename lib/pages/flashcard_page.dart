import 'package:ez_rappel/ui/components/display_wordgroups.dart';
import 'package:ez_rappel/ui/components/flashcard_page/flashcard_widget.dart';
import 'package:flutter/material.dart';

import 'package:ez_rappel/database_utils.dart';

class FlashcardPage extends StatefulWidget {
  final Set<Wordgroup> selectedWordGroups;

  const FlashcardPage({Key? key, required this.selectedWordGroups})
      : super(key: key);

  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
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
          title: const Text("Flashcard Practice"),
        ),
        body: rowFutureBuilder<Wordpair>(
            context,
            _getWordsFromMultipleGroups(widget.selectedWordGroups, db),
            ((wps) => FlashcardWidget(wordpairs: wps))));
  }
}
