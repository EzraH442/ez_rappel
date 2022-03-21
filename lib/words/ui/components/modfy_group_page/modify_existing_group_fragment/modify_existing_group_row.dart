import 'package:flutter/material.dart';
import 'package:luples_flutter/data/entities/word_group.dart';
import 'package:luples_flutter/words/ui/components/display_wordgroups.dart';

class ModifyWordgroupRow extends StatefulWidget {
  static const int unchanged = 0;
  static const int uncommitedChanges = 1;
  static const int commited = 2;
  static const int markedForDelete = 3;

  final int wordgroupId;
  final Wordgroup oldValues;

  final void Function(int id, int newStatus) notifyStatusChange;
  final void Function(int id) removeFromModified;
  final void Function(Wordgroup) commitChanges;

  const ModifyWordgroupRow({
    Key? key,
    required this.wordgroupId,
    required this.oldValues,
    required this.notifyStatusChange,
    required this.removeFromModified,
    required this.commitChanges,
  }) : super(key: key);

  @override
  State<ModifyWordgroupRow> createState() => _ModifyWordgroupRowState();
}

class _ModifyWordgroupRowState extends State<ModifyWordgroupRow> {
  final _nameEC = TextEditingController();
  final _lang1EC = TextEditingController();
  final _lang2EC = TextEditingController();

  int status = ModifyWordgroupRow.unchanged;
  Wordgroup? newValues;

  @override
  void dispose() {
    _nameEC.dispose();
    _lang1EC.dispose();
    _lang2EC.dispose();
    super.dispose();
  }

  _handleCancel() {
    setState(() {
      status = ModifyWordgroupRow.unchanged; //reset to old values
      widget.notifyStatusChange(
          widget.wordgroupId, ModifyWordgroupRow.commited);

      _nameEC.text = widget.oldValues.name;
      _lang1EC.text = widget.oldValues.languageOne;
      _lang2EC.text = widget.oldValues.languageTwo;
    });
  }

  _handleChanged() {
    setState(() {
      status = ModifyWordgroupRow.uncommitedChanges;
      widget.notifyStatusChange(
          widget.wordgroupId, ModifyWordgroupRow.uncommitedChanges);
    });
  }

  _handleCommit() {
    setState(() {
      if (true) {
        status = ModifyWordgroupRow.commited;
        widget.notifyStatusChange(
            widget.wordgroupId, ModifyWordgroupRow.commited);

        newValues = Wordgroup(
            id: widget.wordgroupId,
            name: _nameEC.text,
            languageOne: _lang1EC.text,
            languageTwo: _lang2EC.text,
            dateCreated: DateTime.now().toIso8601String());

        widget.commitChanges(newValues!);
      }
    });
  }

  _handleDelete() {
    setState(() {
      status = ModifyWordgroupRow.markedForDelete;
      widget.notifyStatusChange(
          widget.wordgroupId, ModifyWordgroupRow.markedForDelete);
    });
  }

  _handleHardCancel() {
    setState(() {
      status = ModifyWordgroupRow.unchanged;
      widget.removeFromModified(widget.wordgroupId);
    });
  }

  Color _decideColor() {
    switch (status) {
      case ModifyWordgroupRow.unchanged:
        return Colors.black;
      case ModifyWordgroupRow.uncommitedChanges:
        return Colors.yellow;
      case ModifyWordgroupRow.commited:
        return Colors.green;
      case ModifyWordgroupRow.markedForDelete:
        return Colors.red;
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
              onPressed: _handleCancel,
              icon: const Icon(Icons.undo),
              color: Colors.grey),
          IconButton(
              onPressed: _handleCommit,
              icon: const Icon(Icons.check),
              color: Colors.green),
          IconButton(
              onPressed: _handleDelete,
              icon: const Icon(Icons.delete),
              color: Colors.grey),
          IconButton(
              onPressed: _handleHardCancel,
              icon: const Icon(Icons.cancel),
              color: Colors.black),
        ],
      ))
    ]);
  }
}
