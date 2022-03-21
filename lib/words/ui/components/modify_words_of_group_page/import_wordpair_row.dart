import 'package:flutter/material.dart';

import 'package:luples_flutter/database_utils.dart';

class ImportedWordpairRow extends StatelessWidget {
  final Wordpair wordpair;
  const ImportedWordpairRow({Key? key, required this.wordpair})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(wordpair.wordOne),
        Text(wordpair.wordTwo),
        Text(wordpair.languageOne),
        Text(wordpair.languageTwo),
      ],
    );
  }
}
