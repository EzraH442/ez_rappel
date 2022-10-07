import 'package:ez_rappel/main.dart';
import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';

import 'package:ez_rappel/page_components.dart';
import 'package:provider/provider.dart';

class TypingPracticePage extends StatefulWidget {
  final Set<Tag> selectedTags;

  const TypingPracticePage({Key? key, required this.selectedTags})
      : super(key: key);

  @override
  _TypingPracticePageState createState() => _TypingPracticePageState();
}

class _TypingPracticePageState extends State<TypingPracticePage> {
  Future<List<WordpairTag>> _getWordsFromMultipleGroups(Set<Tag> tags) async {
    List<WordpairTag> ret = [];

    final db = context.read<AppContext>().db;

    for (Tag t in tags) {
      ret.addAll(await db.allWordsFromTagId(t.id));
    }

    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Typing Practice"),
        ),
        body: rowFutureBuilder<Wordpair>(
            context,
            _getWordsFromMultipleGroups(widget.selectedTags),
            ((wps) => TypePracticeWidget(wordpairs: wps))));
  }
}
