import 'dart:math';

import 'package:flutter/material.dart';

import 'package:luples_flutter/database_utils.dart';

class FlashcardPage extends StatefulWidget {
  final Set<Wordgroup> selectedWordGroups;

  const FlashcardPage({Key? key, required this.selectedWordGroups})
      : super(key: key);

  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  @override
  Widget build(BuildContext context) {
    WordDatabaseHelper db = WordDatabaseHelper.instance;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Flashcard Practice"),
        ),
        body: Column(
          children: [
            FutureBuilder<List>(
              future:
                  _getWordsFromMultipleGroups(widget.selectedWordGroups, db),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? _flashcardWidget(_parseDbresult(snapshot.data!))
                    : const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ));
  }
}

List<Wordpair> _parseDbresult(List<dynamic> res) {
  List<Wordpair> ret = [];

  for (dynamic wp in res) {
    ret.add(Wordpair(
        id: wp.id,
        wordOne: wp.word_one,
        wordTwo: wp.word_two,
        languageOne: wp.language_one,
        languageTwo: wp.language_two));
  }

  return ret;
}

Widget _flashcardWidget(List<Wordpair> res) {
  final random = Random();
  bool _swapOrder = false;

  int index = random.nextInt(res.length - 1);

  return Column(
    children: [
      _makeFlashcard(res[index], _swapOrder),
      ListTile(
        title: const Text("Swap front"),
        trailing: const Icon(
          Icons.flip,
        ),
        onTap: () {
          _swapOrder = !_swapOrder;
        },
      )
    ],
  );
}

TextButton _makeFlashcard(Wordpair wordpair, bool swapOrder) {
  bool _flipped = false;
  if (swapOrder) {
    _flipped = !_flipped;
  }

  return TextButton(
    onPressed: () {
      _flipped = !_flipped;
    },
    child: Text(_flipped ? wordpair.wordTwo : wordpair.wordOne),
  );
}

Future<List<Wordpair>> _getWordsFromMultipleGroups(
    Set<Wordgroup> wgs, WordDatabaseHelper db) async {
  List<Wordpair> ret = [];

  for (Wordgroup wg in wgs) {
    ret.addAll(await db.getWordsFromGroup(wg.id));
  }

  return ret;
}
