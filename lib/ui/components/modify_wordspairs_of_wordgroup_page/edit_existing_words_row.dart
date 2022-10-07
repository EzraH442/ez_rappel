import 'package:ez_rappel/storage/tables.dart';
import 'package:ez_rappel/ui/components/display_wordgroups.dart';
import 'package:flutter/material.dart';
import '../modify/button_row.dart';

class ModifyWordpairRow extends EditRow<Wordpair> {
  const ModifyWordpairRow({
    Key? key,
    required id,
    required oldValues,
    required notifyStatusChange,
    required removeFromModified,
    required commitChanges,
  }) : super(
            key: key,
            id: id,
            oldValues: oldValues,
            notifyStatusChange: notifyStatusChange,
            removeFromModified: removeFromModified,
            commitChanges: commitChanges);

  @override
  State<ModifyWordpairRow> createState() => _ModifyWordpairRowState();
}

class _ModifyWordpairRowState extends EditRowState<ModifyWordpairRow> {
  late final _wordOneEC = TextEditingController(text: widget.oldValues.first);
  late final _wordTwoEC = TextEditingController(text: widget.oldValues.second);

  Wordpair? newValues;

  @override
  void dispose() {
    _wordOneEC.dispose();
    _wordTwoEC.dispose();
    super.dispose();
  }

  @override
  handleCancel() {
    _wordOneEC.text = widget.oldValues.first;
    _wordTwoEC.text = widget.oldValues.second;
  }

  @override
  handleCommit() {
    newValues = Wordpair(
      id: widget.id,
      first: _wordOneEC.text,
      second: _wordTwoEC.text,
      user: 0,
    );
    widget.commitChanges(newValues!);
  }

  @override
  Row createTextfieldRow() {
    return Row(children: [
      EditTextfields(textfields: [
        WordpairRowTextfield(
            controller: _wordOneEC,
            onEditingComplete: notifyChanged,
            textColor: decideColor(),
            labelText: "word one"),
        WordpairRowTextfield(
            controller: _wordTwoEC,
            onEditingComplete: notifyChanged,
            textColor: decideColor(),
            labelText: "word two"),
      ])
    ]);
  }
}
