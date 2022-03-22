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
        SizedBox(width: 30, child: Text(wordpair.id.toString())),
        SizedBox(width: 150, child: Text(wordpair.wordOne)),
        SizedBox(width: 150, child: Text(wordpair.wordTwo)),
        SizedBox(width: 30, child: Text(wordpair.languageOne)),
        SizedBox(width: 30, child: Text(wordpair.languageTwo)),
      ],
    );
  }
}
