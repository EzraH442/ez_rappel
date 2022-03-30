import 'package:flutter/material.dart';

import 'package:ez_rappel/database_utils.dart';

class ImportedWordpairRow extends StatelessWidget {
  final Wordpair wordpair;
  const ImportedWordpairRow({Key? key, required this.wordpair})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(wordpair.id.toString())),
        Expanded(flex: 5, child: Text(wordpair.wordOne)),
        Expanded(flex: 5, child: Text(wordpair.wordTwo)),
        Expanded(flex: 1, child: Text(wordpair.languageOne)),
        Expanded(flex: 1, child: Text(wordpair.languageTwo)),
      ],
    );
  }
}
