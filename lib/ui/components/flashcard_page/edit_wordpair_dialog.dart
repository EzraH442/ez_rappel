import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';

import 'package:ez_rappel/ui/components/modify_wordspairs_of_wordgroup_page/edit_existing_words_row.dart';

class EditWordpairDialog extends StatefulWidget {
  final Wordpair wpToEdit;

  const EditWordpairDialog({Key? key, required this.wpToEdit})
      : super(key: key);

  @override
  State<EditWordpairDialog> createState() => _EditWordpairDialogState();
}

class _EditWordpairDialogState extends State<EditWordpairDialog> {
  int _status = ModifyWordpairRow.unchanged;
  Wordpair? _newValues;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Wordpair'),
      content: SingleChildScrollView(
          child: ListBody(children: [
        const Text('Put New Values Below'),
        ModifyWordpairRow(
          wordpairId: widget.wpToEdit.id,
          oldValues: widget.wpToEdit,
          notifyStatusChange: (int id, int status) {
            setState(() {
              _status = status;
            });
          },
          removeFromModified: (int id) {
            setState(() {
              _newValues = null;
            });
          },
          commitChanges: (Wordpair wp) {
            setState(() {
              _newValues = wp;
            });
          },
        )
      ])),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel')),
        TextButton(
          onPressed: () async {
            if (_status == ModifyWordpairRow.commited && _newValues != null) {
              // await WordDatabaseHelper.instance.updateWordpair(_newValues!);
              Navigator.of(context).pop(_newValues);
            }
          },
          child: Text(
            'Confirm',
            style: TextStyle(
              color: (_status == ModifyWordpairRow.commited)
                  ? Colors.green
                  : Colors.red,
            ),
          ),
        )
      ],
    );
  }
}

Future<Wordpair?> openEditWordpairDialog(
    BuildContext context, Wordpair wpToEdit) async {
  return showDialog<Wordpair?>(
      context: context,
      builder: (context) => EditWordpairDialog(wpToEdit: wpToEdit));
}
