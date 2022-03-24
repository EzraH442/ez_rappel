import 'package:flutter/material.dart';

import 'dart:io';

import 'package:ez_rappel/database_utils.dart';
import 'package:ez_rappel/file_utils.dart';

import 'import_wordpair_file.dart';

class ImportWordpairsToWordgroupSection extends StatefulWidget {
  final int associatedWordgroupId;

  final void Function() notifyWordsAdded;

  const ImportWordpairsToWordgroupSection(
      {Key? key,
      required this.associatedWordgroupId,
      required this.notifyWordsAdded})
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
      } else {}
    } else {
      List<int> insertedIds = await _db.insertAllWordpairs(wordPairs!);
      _db.addAllWordpairsToGroup(insertedIds, widget.associatedWordgroupId);
    }
    setState(() {
      wordPairs = null;
      _hasSelectedFile = false;
    });
    widget.notifyWordsAdded();
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

  void _onCancel() {
    setState(() {
      _idsProvided = false;
      _keepExistingWordpairs = false;
      _hasSelectedFile = false;
      wordPairs = null;
    });
  }

  Row _buildButtonRow() {
    return Row(
      children: [
        _hasSelectedFile
            ? Row(children: [
                TextButton(onPressed: _onCancel, child: const Text("Cancel")),
                const Text("IDs provided?"),
                Checkbox(value: _idsProvided, onChanged: _onIdCheckboxChanged),
                _idsProvided
                    ? Row(children: [
                        const Text("Ignore existing IDs ?"),
                        Checkbox(
                            value: _keepExistingWordpairs,
                            onChanged: _onKeepExistingCheckboxChanged),
                      ])
                    : Row(),
                TextButton(
                    onPressed: _addWordsToGroup, child: const Text("Import")),
              ])
            : TextButton(
                onPressed: _initiateFileSelect,
                child: const Text("Import a CSV file")),
      ],
    );
  }

  @override
  ListView build(BuildContext context) {
    return ListView(
      children: [
        _hasSelectedFile
            ? ImportedWordpairsSection(
                associatedWordgroupId: widget.associatedWordgroupId,
                wordPairs: wordPairs!)
            : const Text("No file selected"),
        _buildButtonRow()
      ],
    );
  }
}
