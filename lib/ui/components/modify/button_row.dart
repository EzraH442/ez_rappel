import 'package:flutter/material.dart';

class EditTextfields<T extends Container> extends StatelessWidget {
  final List<T> textfields;
  const EditTextfields({Key? key, required this.textfields}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(children: textfields.map((e) => Expanded(child: e)).toList()),
    );
  }
}

class ButtonRow extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final VoidCallback onDelete;
  final VoidCallback onReset;
  const ButtonRow(
      {Key? key,
      required this.onCancel,
      required this.onSave,
      required this.onDelete,
      required this.onReset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: onCancel,
            icon: const Icon(Icons.undo),
            color: Colors.grey),
        IconButton(
            onPressed: onSave,
            icon: const Icon(Icons.check),
            color: Colors.green),
        IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete),
            color: Colors.grey),
        IconButton(
            onPressed: onReset,
            icon: const Icon(Icons.cancel),
            color: Colors.black),
      ],
    );
  }
}

abstract class EditRow<T> extends StatefulWidget {
  static const int unchanged = 0;
  static const int uncommitedChanges = 1;
  static const int commited = 2;
  static const int markedForDelete = 3;

  final int id;
  final T oldValues;

  final void Function(int id, int newStatus) notifyStatusChange;
  final void Function(int id) removeFromModified;
  final void Function(T) commitChanges;

  const EditRow(
      {Key? key,
      required this.id,
      required this.oldValues,
      required this.notifyStatusChange,
      required this.removeFromModified,
      required this.commitChanges})
      : super(key: key);
}

abstract class EditRowState<T extends EditRow> extends State<T> {
  int status = EditRow.unchanged;
  bool isEditing = false;

  @protected
  Color decideColor() {
    switch (status) {
      case EditRow.unchanged:
        return Colors.black;
      case EditRow.uncommitedChanges:
        return Colors.yellow;
      case EditRow.commited:
        return Colors.green;
      case EditRow.markedForDelete:
        return Colors.red;
    }
    return Colors.brown;
  }

  void notifyChanged() {
    setState(() {
      status = EditRow.uncommitedChanges;
      widget.notifyStatusChange(widget.id, EditRow.uncommitedChanges);
    });
  }

  Row createTextfieldRow();

  void handleCancel() {}
  void handleCommit() {}
  void handleDelete() {}
  void handleHardCancel() {}

  @override
  Widget build(BuildContext context) {
    return isEditing
        ? Row(children: [
            createTextfieldRow(),
            ButtonRow(onCancel: () {
              setState(() {
                status = EditRow.unchanged;
                widget.notifyStatusChange(widget.id, EditRow.commited);
                handleCancel();
              });
            }, onSave: () {
              setState(() {
                status = EditRow.commited;
                widget.notifyStatusChange(widget.id, EditRow.commited);
                handleCommit();
              });
            }, onDelete: () {
              setState(() {
                status = EditRow.markedForDelete;
                widget.notifyStatusChange(widget.id, EditRow.markedForDelete);
                handleDelete();
              });
            }, onReset: () {
              setState(() {
                status = EditRow.unchanged;
                widget.removeFromModified(widget.id);
                handleHardCancel();
              });
            })
          ])
        : Row(children: const [Text("data")]);
  }
}
