import 'package:ez_rappel/storage/tables.dart';
import 'package:ez_rappel/ui/components/dialog/dialog.dart';
import 'package:ez_rappel/ui/components/modify/button_row.dart';
import 'package:flutter/material.dart';

import 'package:ez_rappel/ui/components/modify_wordspairs_of_wordgroup_page/edit_existing_words_row.dart';

class EditWordpairDialog<Wordpair> extends EditDialog {
  const EditWordpairDialog({Key? key, required itemToEdit})
      : super(
            key: key,
            itemToEdit: itemToEdit,
            title: "Edit Wordpair",
            subtitle: "Put New Values Below");

  @override
  State<EditWordpairDialog> createState() => _EditWordpairDialogState();
}

class _EditWordpairDialogState extends EditDialogState<EditWordpairDialog> {
  int _status = EditRow.unchanged;
  Wordpair? _newValues;

  @override
  void initState() {
    super.initState();
  }

  @override
  createEditRow() {
    return ModifyWordpairRow(
      id: widget.itemToEdit.id,
      oldValues: widget.itemToEdit,
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
    );
  }

  @override
  onConfirm() async {
    if (_status == EditRow.commited && _newValues != null) {
      // await WordDatabaseHelper.instance.updateWordpair(_newValues!);
      Navigator.of(context).pop(_newValues);
    }
  }
}

Future<Wordpair?> openEditWordpairDialog(
    BuildContext context, Wordpair wpToEdit) async {
  return showDialog<Wordpair?>(
      context: context,
      builder: (context) => EditWordpairDialog(itemToEdit: wpToEdit));
}
