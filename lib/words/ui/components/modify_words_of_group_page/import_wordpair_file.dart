import 'package:flutter/material.dart';

import 'package:ez_rappel/database_utils.dart';

import 'import_wordpair_row.dart';

class ImportWordpairsSection extends StatefulWidget {
  final int associatedWordgroupId;
  final List<Wordpair> wordPairs;

  const ImportWordpairsSection(
      {Key? key, required this.associatedWordgroupId, required this.wordPairs})
      : super(key: key);

  @override
  State<ImportWordpairsSection> createState() => _ImportWordpairsSectionState();
}

class _ImportWordpairsSectionState extends State<ImportWordpairsSection> {
  Widget _buildColumn(List<Wordpair> wps) {
    return Column(
      children: wps.map((e) => ImportedWordpairRow(wordpair: e)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: _buildColumn(widget.wordPairs));
  }
}
