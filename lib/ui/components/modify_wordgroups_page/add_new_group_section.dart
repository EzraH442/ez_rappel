import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ez_rappel/database_utils.dart';
import '../display_wordgroups.dart';
import 'add_new_group_row.dart';

class AddNewWordgroupSection extends StatefulWidget {
  final WordDatabaseHelper database;

  final void Function() notifyExecution;

  const AddNewWordgroupSection(
      {Key? key, required this.database, required this.notifyExecution})
      : super(key: key);

  @override
  State<AddNewWordgroupSection> createState() => _AddNewWordgroupSectionState();
}

class _AddNewWordgroupSectionState extends State<AddNewWordgroupSection> {
  final _groupsToAdd =
      LinkedHashSet<Wordgroup>(equals: (p0, p1) => p0.id == p1.id);
  final _rows = LinkedHashSet<AddNewWordgroupRow>(
      equals: (p0, p1) => p1.rowId == p1.rowId);
  int _nextId = 0;

  _putGroup(Wordgroup wg) {
    setState(() {
      _groupsToAdd.add(wg);
    });
  }

  _removeGroup(int id, Wordgroup? wg) {
    setState(() {
      if (wg != null) {
        _groupsToAdd.remove(wg);
      }
      AddNewWordgroupRow associatedRow =
          _rows.firstWhere((element) => element.rowId == id);
      _rows.remove(associatedRow);
    });
  }

  _addNewRow() {
    setState(() {
      _rows.add(AddNewWordgroupRow(
          notifyCancel: _removeGroup,
          notifyConfirm: _putGroup,
          rowId: _nextId));
      _nextId++;
    });
  }

  _executeChanges() async {
    for (Wordgroup wg in _groupsToAdd) {
      await widget.database.insertWordgroup(wg);
    }
    setState(() {
      _rows.clear();
      _groupsToAdd.clear();
      widget.notifyExecution();
    });
  }

  _resetAllChanges() {
    setState(() {
      _rows.clear();
      _groupsToAdd.clear();
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
        addNewButton(onPressed: _addNewRow),
        confirmButton(onPressed: _executeChanges),
        cancelButton(onPressed: _resetAllChanges)
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
