import 'package:flutter/material.dart';
import 'package:ez_rappel/database_utils.dart';
import '../display_wordgroups.dart';

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
  late final _nameEC = TextEditingController(text: widget.oldValues.name);
  late final _lang1EC =
      TextEditingController(text: widget.oldValues.languageOne);
  late final _lang2EC =
      TextEditingController(text: widget.oldValues.languageTwo);

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
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
          child: wordgroupEditingRow(
              nameController: _nameEC,
              languageOneController: _lang1EC,
              languageTwoController: _lang2EC,
              handleChange: _handleChanged,
              textColor: _decideColor())),
      Row(
        mainAxisSize: MainAxisSize.min,
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
      )
    ]);
  }
}
