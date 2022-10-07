import 'package:ez_rappel/ui/components/modify/button_row.dart';
import 'package:flutter/material.dart';

abstract class EditDialog<T> extends StatefulWidget {
  final T itemToEdit;
  final String title;
  final String subtitle;

  const EditDialog({
    Key? key,
    required this.itemToEdit,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
}

abstract class EditDialogState<T extends EditDialog> extends State<T> {
  @protected
  final int _status = EditRow.unchanged;

  @override
  void initState() {
    super.initState();
  }

  onConfirm();

  createEditRow();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
          child: ListBody(children: [Text(widget.subtitle), createEditRow()])),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel')),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            'Confirm',
            style: TextStyle(
              color: (_status == EditRow.commited) ? Colors.green : Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
