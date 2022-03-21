import 'package:flutter/material.dart';

import 'dart:io';

import 'package:ez_rappel/database_utils.dart';
import 'package:ez_rappel/file_utils.dart';

import 'import_wordpair_file.dart';

class ImportWordpairsToWordgroupSection extends StatefulWidget {
  final int associatedWordgroupId;

  const ImportWordpairsToWordgroupSection(
      {Key? key, required this.associatedWordgroupId})
      : super(key: key);

  @override
  State<ImportWordpairsToWordgroupSection> createState() =>
      _ImportWordpairsToWordgroupSectionState();
}

class _ImportWordpairsToWordgroupSectionState
    extends State<ImportWordpairsToWordgroupSection> {
  final _fileHelper = FileHelper();
  final _db = WordDatabaseHelper.instance;
  bool _preserveIds = false;

  bool _hasSelectedFile = false;
  List<Wordpair>? wordPairs;

  void _initiateFileSelect() async {
    File? f = await _fileHelper.readlocalFileOrNull();
    if (f == null) return;
    List<Wordpair>? result = await _fileHelper.readWordpairFile(f);
    if (result == null) return;

    setState(() {
      wordPairs = result;
      _hasSelectedFile = true;
    });
  }

  void _addWordsToGroup() {
    _db.insertAllWordpairs(wordPairs!);
    if (_preserveIds) {
      _db.addAllWordpairsToGroup(
          wordPairs!.map((e) => e.id).toList(), widget.associatedWordgroupId);
    }
  }

  void _onCheckboxChanged(bool? checked) {
    setState(() {
      _preserveIds = !_preserveIds;
    });
  }

  Row _buildButtonRow() {
    return Row(
      children: [
        TextButton(
            onPressed: _initiateFileSelect, child: const Text("Select A File")),
        TextButton(onPressed: _addWordsToGroup, child: const Text("confirm!")),
        Row(children: [
          const Text("Preserve Ids?"),
          Checkbox(value: _preserveIds, onChanged: _onCheckboxChanged),
        ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        child: ListView(
          children: [
            _hasSelectedFile
                ? ImportWordpairsSection(
                    associatedWordgroupId: widget.associatedWordgroupId,
                    wordPairs: wordPairs!)
                : const Text("..."),
            _buildButtonRow()
          ],
        ));
  }
}
