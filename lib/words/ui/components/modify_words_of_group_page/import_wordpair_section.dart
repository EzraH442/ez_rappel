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
  bool _idsProvided = false;
  bool _keepExistingWordpairs = false;

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

  void _addWordsToGroup() async {
    if (_idsProvided) {
      if (_keepExistingWordpairs) {

      } else {
        
      }
    } else {
      List<int> insertedIds = await _db.insertAllWordpairs(wordPairs!);
      _db.addAllWordpairsToGroup(insertedIds, widget.associatedWordgroupId);
    }
  }

  void _onIdCheckboxChanged(bool? checked) {
    setState(() {
      _idsProvided = !_idsProvided;
    });
  }

  void _onKeepExistingCheckboxChanged(bool? checked) {
    setState(() {
      _keepExistingWordpairs = !_keepExistingWordpairs;
    });
  }

  Row _buildButtonRow() {
    return Row(
      children: [
        TextButton(
            onPressed: _initiateFileSelect, child: const Text("Select A File")),
        TextButton(onPressed: _addWordsToGroup, child: const Text("confirm!")),
        Row(children: [
          const Text("IDs provided?"),
          Checkbox(value: _idsProvided, onChanged: _onIdCheckboxChanged),
        ]),
        _idsProvided
            ? Row(children: [
                const Text("Ignore existing IDs ?"),
                Checkbox(
                    value: _keepExistingWordpairs,
                    onChanged: _onKeepExistingCheckboxChanged),
              ])
            : Row(),
      ],
    );
  }

  @override
  ListView build(BuildContext context) {
    return ListView(
      children: [
        _hasSelectedFile
            ? ImportWordpairsSection(
                associatedWordgroupId: widget.associatedWordgroupId,
                wordPairs: wordPairs!)
            : const Text("..."),
        _buildButtonRow()
      ],
    );
  }
}
