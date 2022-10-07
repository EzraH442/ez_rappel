import 'package:ez_rappel/main.dart';
import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:ez_rappel/file_utils.dart';
import 'package:provider/provider.dart';

import 'import_wordpair_file.dart';

class ImportWordpairsToTagSection extends StatefulWidget {
  final int tagId;

  final void Function() notifyWordsAdded;

  const ImportWordpairsToTagSection(
      {Key? key, required this.tagId, required this.notifyWordsAdded})
      : super(key: key);

  @override
  State<ImportWordpairsToTagSection> createState() =>
      _ImportWordpairsToTagSectionState();
}

class _ImportWordpairsToTagSectionState
    extends State<ImportWordpairsToTagSection> {
  final _fileHelper = FileHelper();
  bool _idsProvided = false;
  bool _replaceExistingWordpairs = false;

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
    final _db = context.read<AppContext>().db;
    if (_idsProvided) {
      if (_replaceExistingWordpairs) {
      } else {}
    } else {
      await _db.insertMultipleWordpairs(wordPairs!);
      _db.addMultipleWordpairToTag(wordPairs!
          .map((wp) => WordpairTag(wpId: wp.id, tagId: widget.tagId))
          .toList());
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
      _replaceExistingWordpairs = !_replaceExistingWordpairs;
    });
  }

  void _onCancel() {
    setState(() {
      _idsProvided = false;
      _replaceExistingWordpairs = false;
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
                        const Text("Replace existing wordpairs?"),
                        Checkbox(
                            value: _replaceExistingWordpairs,
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
                tagId: widget.tagId, wordPairs: wordPairs!)
            : const Text("No file selected"),
        _buildButtonRow()
      ],
    );
  }
}
