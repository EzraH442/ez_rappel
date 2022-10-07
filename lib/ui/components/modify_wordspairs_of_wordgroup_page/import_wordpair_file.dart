import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';

import 'import_wordpair_row.dart';

class ImportedWordpairsSection extends StatelessWidget {
  final int tagId;
  final List<Wordpair> wordPairs;

  const ImportedWordpairsSection(
      {Key? key, required this.tagId, required this.wordPairs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            SizedBox(width: 30, child: Text("id")),
            SizedBox(width: 150, child: Text("first")),
            SizedBox(width: 150, child: Text("second")),
          ],
        ),
        Column(
            children:
                wordPairs.map((e) => ImportedWordpairRow(wordpair: e)).toList())
      ],
    );
  }
}
