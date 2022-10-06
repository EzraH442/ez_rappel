import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';
import '../display_wordgroups.dart';

class AddNewTag extends StatefulWidget {
  static const empty = 0;
  static const unsavedChanges = 1;
  static const saved = 2;

  final int rowId;
  final Function(Tag) onConfirm;
  final Function(int, Tag) onCancel;

  const AddNewTag(
      {Key? key,
      required this.rowId,
      required this.onConfirm,
      required this.onCancel})
      : super(key: key);

  @override
  State<AddNewTag> createState() => _AddNewTagState();
}

class _AddNewTagState extends State<AddNewTag> {
  final _nameEC = TextEditingController();
  final _lang1EC = TextEditingController();
  final _lang2EC = TextEditingController();

  int _state = AddNewTag.empty;
  Tag? tag;

  @override
  void dispose() {
    _nameEC.dispose();
    _lang1EC.dispose();
    _lang2EC.dispose();
    super.dispose();
  }

  _handleChanged() {
    setState(() {
      _state = AddNewTag.unsavedChanges;
    });
  }

  _handleConfirm() {
    setState(() {
      if (true) {
        tag = Tag(
          user: 0, // TODO users
          id: widget.rowId,
          name: _nameEC.text,
        );

        _state = AddNewTag.saved;
        widget.onConfirm(tag!);
      }
    });
  }

  _handleCancel() {
    setState(() {
      widget.onCancel(widget.rowId, tag);
      _nameEC.text = "";
      _lang1EC.text = "";
      _lang2EC.text = "";
    });
  }

  Color _decideColor() {
    switch (_state) {
      case AddNewTag.unsavedChanges:
        return Colors.yellow;
      case AddNewTag.saved:
        return Colors.green;
      case AddNewTag.empty:
        return Colors.black;
    }
    return Colors.brown;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
          child: wordgroupEditingRow(
              nameController: _nameEC,
              handleChange: _handleChanged,
              textColor: _decideColor())),
      Row(
        children: [
          IconButton(
              onPressed: _handleConfirm,
              icon: const Icon(Icons.check),
              color: Colors.green),
          IconButton(
              onPressed: _handleCancel,
              icon: const Icon(Icons.delete),
              color: Colors.black),
        ],
      )
    ]);
  }
}
