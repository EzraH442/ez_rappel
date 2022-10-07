import 'package:ez_rappel/main.dart';
import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';

import 'package:ez_rappel/page_components.dart';
import 'package:provider/provider.dart';

class FlashcardPage extends StatefulWidget {
  final Set<Tag> selectedTags;

  const FlashcardPage({Key? key, required this.selectedTags}) : super(key: key);

  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  Future<List<WordpairTag>> _getWordsFromTags(Set<Tag> tags) async {
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
          title: const Text("Flashcard Practice"),
        ),
        body: rowFutureBuilder<Wordpair>(
            context,
            _getWordsFromTags(widget.selectedTags),
            ((wps) => FlashcardWidget(wordpairs: wps))));
  }
}
