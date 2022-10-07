import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';
import '../display_wordgroups.dart';
import '../modify/button_row.dart';

class ModifyTagpRow extends EditRow<Tag> {
  const ModifyTagpRow({
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
  State<ModifyTagpRow> createState() => _ModifyTagRowState();
}

class _ModifyTagRowState extends EditRowState<ModifyTagpRow> {
  late final _nameEC = TextEditingController(text: widget.oldValues.name);
  Tag? newValues;

  @override
  void dispose() {
    _nameEC.dispose();
    super.dispose();
  }

  @override
  handleCancel() {
    _nameEC.text = widget.oldValues.name;
  }

  @override
  handleCommit() {
    newValues = Tag(id: widget.id, name: _nameEC.text, user: 0);
    widget.commitChanges(newValues!);
  }

  @override
  Row createTextfieldRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
          child: TagEditingRow(
              nameController: _nameEC,
              handleChange: notifyChanged,
              textColor: decideColor()))
    ]);
  }
}
