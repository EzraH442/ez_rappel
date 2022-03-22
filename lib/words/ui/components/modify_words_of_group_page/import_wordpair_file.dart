import 'package:flutter/material.dart';

import 'package:ez_rappel/database_utils.dart';

import 'import_wordpair_row.dart';

class ImportedWordpairsSection extends StatelessWidget {
  final int associatedWordgroupId;
  final List<Wordpair> wordPairs;

  const ImportedWordpairsSection(
      {Key? key, required this.associatedWordgroupId, required this.wordPairs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 30, child: Text("id")),
            SizedBox(width: 150, child: Text("word_one")),
            SizedBox(width: 150, child: Text("word_two")),
            SizedBox(width: 30, child: Text("L_1")),
            SizedBox(width: 30, child: Text("L_2")),
          ],
        ),
        Column(
            children:
                wordPairs.map((e) => ImportedWordpairRow(wordpair: e)).toList())
      ],
    );
  }
}
