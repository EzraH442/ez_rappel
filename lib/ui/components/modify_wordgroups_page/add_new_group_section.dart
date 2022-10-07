import 'dart:collection';

import 'package:ez_rappel/main.dart';
import 'package:ez_rappel/storage/tables.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../display_wordgroups.dart';
import 'add_new_group_row.dart';

class AddNewWordgroupSection extends StatefulWidget {
  final void Function() notifyExecution;

  const AddNewWordgroupSection({Key? key, required this.notifyExecution})
      : super(key: key);

  @override
  State<AddNewWordgroupSection> createState() => _AddNewWordgroupSectionState();
}

class _AddNewWordgroupSectionState extends State<AddNewWordgroupSection> {
  final _tagsToAdd = LinkedHashSet<Tag>(equals: (p0, p1) => p0.id == p1.id);
  final _rows =
      LinkedHashSet<AddNewTag>(equals: (p0, p1) => p1.rowId == p1.rowId);
  int _nextId = 0;

  _putGroup(Tag t) {
    setState(() {
      _tagsToAdd.add(t);
    });
  }

  _removeGroup(int id, Tag? t) {
    setState(() {
      if (t != null) {
        _tagsToAdd.remove(t);
      }
      AddNewTag associatedRow =
          _rows.firstWhere((element) => element.rowId == id);
      _rows.remove(associatedRow);
    });
  }

  _addNewRow() {
    setState(() {
      _rows.add(AddNewTag(
        rowId: _nextId,
        onConfirm: _putGroup,
        onCancel: _removeGroup,
      ));
      _nextId++;
    });
  }

  _executeChanges() async {
    final db = context.read<AppContext>().db;
    db.insertMultipleTags(_tagsToAdd.toList());
    setState(() {
      _rows.clear();
      _tagsToAdd.clear();
      widget.notifyExecution();
    });
  }

  _resetAllChanges() {
    setState(() {
      _rows.clear();
      _tagsToAdd.clear();
    });
  }

  Column _buildMainColumn() {
    List<Widget> widgets = [];
    widgets.add(const Divider(
      color: Colors.black,
      height: 2,
      indent: 12,
      endIndent: 12,
      thickness: 2,
    ));
    widgets.addAll(_rows.toList());

    return Column(children: widgets);
  }

  Row _buildMainButtons() {
    return Row(
      children: [
        AddNewButton(onPressed: _addNewRow),
        ConfirmButton(onPressed: _executeChanges),
        CancelButton(onPressed: _resetAllChanges)
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMainColumn(),
        _buildMainButtons(),
      ],
    );
  }
}
