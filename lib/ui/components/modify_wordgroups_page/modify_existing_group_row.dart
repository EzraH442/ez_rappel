import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';
import '../display_wordgroups.dart';

class ModifyWordgroupRow extends StatefulWidget {
  static const int unchanged = 0;
  static const int uncommitedChanges = 1;
  static const int commited = 2;
  static const int markedForDelete = 3;

  final int wordgroupId;
  final Tag oldValues;

  final void Function(int id, int newStatus) notifyStatusChange;
  final void Function(int id) removeFromModified;
  final void Function(Tag) commitChanges;

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

  int status = ModifyWordgroupRow.unchanged;
  Tag? newValues;

  @override
  void dispose() {
    _nameEC.dispose();
    super.dispose();
  }

  _handleCancel() {
    setState(() {
      status = ModifyWordgroupRow.unchanged; //reset to old values
      widget.notifyStatusChange(
          widget.wordgroupId, ModifyWordgroupRow.commited);

      _nameEC.text = widget.oldValues.name;
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

        newValues = Tag(
          id: widget.wordgroupId,
          name: _nameEC.text,
          user: 0,
        );

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
