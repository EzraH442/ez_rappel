import 'package:flutter/material.dart';
import 'package:ez_rappel/database_utils.dart';
import 'package:ez_rappel/words/ui/components/display_wordgroups.dart';

class ModifyWordpairRow extends StatefulWidget {
  static const int unchanged = 0;
  static const int uncommitedChanges = 1;
  static const int commited = 2;
  static const int markedForDelete = 3;

  final int wordpairId;
  final Wordpair oldValues;

  final void Function(int id, int newStatus) notifyStatusChange;
  final void Function(int id) removeFromModified;
  final void Function(Wordpair) commitChanges;

  const ModifyWordpairRow({
    Key? key,
    required this.wordpairId,
    required this.oldValues,
    required this.notifyStatusChange,
    required this.removeFromModified,
    required this.commitChanges,
  }) : super(key: key);

  @override
  State<ModifyWordpairRow> createState() => _ModifyWordpairRowState();
}

class _ModifyWordpairRowState extends State<ModifyWordpairRow> {
  final _wordOneEC = TextEditingController();
  final _wordTwoEC = TextEditingController();

  int status = ModifyWordpairRow.unchanged;
  Wordpair? newValues;

  @override
  void dispose() {
    _wordOneEC.dispose();
    _wordTwoEC.dispose();
    super.dispose();
  }

  _handleCancel() {
    setState(() {
      status = ModifyWordpairRow.unchanged; //reset to old values
      widget.notifyStatusChange(widget.wordpairId, ModifyWordpairRow.commited);

      _wordOneEC.text = widget.oldValues.wordOne;
      _wordTwoEC.text = widget.oldValues.wordTwo;
    });
  }

  _handleChanged() {
    setState(() {
      status = ModifyWordpairRow.uncommitedChanges;
      widget.notifyStatusChange(
          widget.wordpairId, ModifyWordpairRow.uncommitedChanges);
    });
  }

  _handleCommit() {
    setState(() {
      if (true) {
        status = ModifyWordpairRow.commited;
        widget.notifyStatusChange(
            widget.wordpairId, ModifyWordpairRow.commited);

        newValues = Wordpair(
            id: widget.wordpairId,
            wordOne: _wordOneEC.text,
            wordTwo: _wordTwoEC.text,
            languageOne: widget.oldValues.languageOne,
            languageTwo: widget.oldValues.languageTwo);

        widget.commitChanges(newValues!);
      }
    });
  }

  _handleDelete() {
    setState(() {
      status = ModifyWordpairRow.markedForDelete;
      widget.notifyStatusChange(
          widget.wordpairId, ModifyWordpairRow.markedForDelete);
    });
  }

  _handleHardCancel() {
    setState(() {
      status = ModifyWordpairRow.unchanged;
      widget.removeFromModified(widget.wordpairId);
    });
  }

  Color _decideColor() {
    switch (status) {
      case ModifyWordpairRow.unchanged:
        return Colors.black;
      case ModifyWordpairRow.uncommitedChanges:
        return Colors.yellow;
      case ModifyWordpairRow.commited:
        return Colors.green;
      case ModifyWordpairRow.markedForDelete:
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
            wordpairRowTextfield(
                controller: _wordOneEC,
                onEditingComplete: _handleChanged,
                textColor: _decideColor(),
                labelText: "word one"),
            wordpairRowTextfield(
                controller: _wordTwoEC,
                onEditingComplete: _handleChanged,
                textColor: _decideColor(),
                labelText: "word two"),
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
