import 'package:flutter/material.dart';
import 'package:luples_flutter/data/entities/word_group.dart';
import 'package:luples_flutter/words/ui/components/display_wordgroups.dart';

class AddNewWordgroupRow extends StatefulWidget {
  static const empty = 0;
  static const unsavedChanges = 1;
  static const saved = 2;

  final int rowId;
  final void Function(Wordgroup) notifyConfirm;
  final void Function(int, Wordgroup?) notifyCancel;

  const AddNewWordgroupRow(
      {Key? key,
      required this.notifyCancel,
      required this.notifyConfirm,
      required this.rowId})
      : super(key: key);

  @override
  State<AddNewWordgroupRow> createState() => _AddNewWordgroupRowState();
}

class _AddNewWordgroupRowState extends State<AddNewWordgroupRow> {
  final _nameEC = TextEditingController();
  final _lang1EC = TextEditingController();
  final _lang2EC = TextEditingController();

  int _state = AddNewWordgroupRow.empty;
  Wordgroup? wordGroup;

  @override
  void dispose() {
    _nameEC.dispose();
    _lang1EC.dispose();
    _lang2EC.dispose();
    super.dispose();
  }

  _handleChanged() {
    setState(() {
      _state = AddNewWordgroupRow.unsavedChanges;
    });
  }

  _handleConfirm() {
    setState(() {
      if (true) {
        wordGroup = Wordgroup(
            id: widget.rowId,
            name: _nameEC.text,
            languageOne: _lang1EC.text,
            languageTwo: _lang2EC.text,
            dateCreated: DateTime.now().toIso8601String());

        _state = AddNewWordgroupRow.saved;
        widget.notifyConfirm(wordGroup!);
      }
    });
  }

  _handleCancel() {
    setState(() {
      widget.notifyCancel(widget.rowId, wordGroup);
      _nameEC.text = "";
      _lang1EC.text = "";
      _lang2EC.text = "";
    });
  }

  Color _decideColor() {
    switch (_state) {
      case AddNewWordgroupRow.unsavedChanges:
        return Colors.yellow;
      case AddNewWordgroupRow.saved:
        return Colors.green;
      case AddNewWordgroupRow.empty:
        return Colors.black;
    }
    return Colors.brown;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        child: Row(
          children: [
            modifyWordgroupRowFutureBuilder(
                width: 250,
                controller: _nameEC,
                onEditingComplete: _handleChanged,
                color: _decideColor(),
                maxLength: 20,
                labelText: "Name"),
            modifyWordgroupRowFutureBuilder(
                width: 100,
                controller: _lang1EC,
                onEditingComplete: _handleChanged,
                color: _decideColor(),
                maxLength: 3,
                labelText: "lang 1"),
            modifyWordgroupRowFutureBuilder(
                width: 100,
                controller: _lang2EC,
                onEditingComplete: _handleChanged,
                color: _decideColor(),
                maxLength: 3,
                labelText: "lang 2"),
          ],
        ),
      ),
      Expanded(
          child: Row(
        children: [
          IconButton(
              onPressed: _handleConfirm,
              icon: const Icon(Icons.check),
              color: Colors.green),
          IconButton(
              onPressed: _handleCancel,
              icon: const Icon(Icons.delete),
              color: Colors.black),
        ],
      ))
    ]);
  }
}
