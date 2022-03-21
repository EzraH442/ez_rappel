import 'package:flutter/material.dart';

import 'dart:io';

import 'package:ez_rappel/database_utils.dart';
import 'package:ez_rappel/file_utils.dart';

import 'import_wordpair_file.dart';

class ImportWordpairsToWordgroupPage extends StatefulWidget {
  final Wordgroup associatedWordgroup;

  const ImportWordpairsToWordgroupPage(
      {Key? key, required this.associatedWordgroup})
      : super(key: key);

  @override
  State<ImportWordpairsToWordgroupPage> createState() =>
      _ImportWordpairsToWordgroupPageState();
}

class _ImportWordpairsToWordgroupPageState
    extends State<ImportWordpairsToWordgroupPage> {
  final _fileHelper = FileHelper();
  final _db = WordDatabaseHelper.instance;

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

  Row _buildButtonRow() {
    return Row(
      children: [
        TextButton(
            onPressed: _initiateFileSelect, child: const Text("Select A File")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _hasSelectedFile
            ? ImportWordpairsSection(
                associatedWordgroupId: widget.associatedWordgroup.id,
                wordPairs: wordPairs!)
            : const Text("..."),
        _buildButtonRow()
      ],
    ));
  }
}
