import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';

class ImportedWordpairRow extends StatelessWidget {
  final Wordpair wordpair;
  const ImportedWordpairRow({Key? key, required this.wordpair})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(wordpair.id.toString())),
        Expanded(flex: 5, child: Text(wordpair.first)),
        Expanded(flex: 5, child: Text(wordpair.second)),
      ],
    );
  }
}
