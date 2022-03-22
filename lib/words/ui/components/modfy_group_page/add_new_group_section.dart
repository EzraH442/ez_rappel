import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ez_rappel/database_utils.dart';
import 'package:ez_rappel/words/ui/components/display_wordgroups.dart';
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
    List<AddNewWordgroupRow> rows = _rows.toList();

    return Column(
      children: rows,
    );
  }

  Row _buildMainButtons() {
    return Row(children: [
      mainTextButton(
          onPressed: _addNewRow, buttonText: "Add Another Wordgroup"),
      mainTextButton(onPressed: _executeChanges, buttonText: "Confirm"),
      mainTextButton(onPressed: _resetAllChanges, buttonText: "Cancel"),
    ]);
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
