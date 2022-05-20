import 'package:flutter/material.dart';

import 'package:ez_rappel/database_utils.dart';

import '../display_wordgroups.dart';
import 'modify_existing_group_row.dart';

class ModifyExistingWordgroupsSection extends StatefulWidget {
  final WordDatabaseHelper database;
  const ModifyExistingWordgroupsSection({
    Key? key,
    required this.database,
  }) : super(key: key);

  @override
  State<ModifyExistingWordgroupsSection> createState() =>
      _ModifyExistingWordgroupsSectionState();
}

class _ModifyExistingWordgroupsSectionState
    extends State<ModifyExistingWordgroupsSection> {
  final _modifiedIds = <int, int>{};
  final _modifiedExistingGroups = <int, Wordgroup>{};

  _notifyExistingWordgroupStatusChange(int id, int status) {
    setState(() {
      _modifiedIds[id] = status;
    });
  }

  _removeFromExisitingWordgroupsModified(int id) {
    setState(() {
      _modifiedIds.remove(id);
      _modifiedExistingGroups.remove(id);
    });
  }

  _addToModifiedExistingGroups(Wordgroup wg) {
    setState(() {
      _modifiedExistingGroups[wg.id] = wg;
    });
  }

  Row _buildMainButtons() {
    return Row(
      children: [
        confirmButton(onPressed: _executeChanges),
        cancelButton(onPressed: _resetAllChanges),
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  }

  Column _buildExistingGroupsColumn(List<Wordgroup> wgs) {
    if (wgs.isEmpty) {
      return Column(children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Add your first wordgroup below!"),
        )
      ]);
    } else {
      List<Widget> widgets = [];
      widgets.addAll(wgs.map((wg) {
        if (_modifiedIds.containsKey(wg.id)) {
          return ModifyWordgroupRow(
            wordgroupId: wg.id,
            oldValues: wg,
            notifyStatusChange: _notifyExistingWordgroupStatusChange,
            removeFromModified: _removeFromExisitingWordgroupsModified,
            commitChanges: _addToModifiedExistingGroups,
          );
        } else {
          return ListTile(
            leading: Text(wg.name),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _notifyExistingWordgroupStatusChange(
                  wg.id, ModifyWordgroupRow.unchanged),
            ),
          );
        }
      }).toList());
      widgets.add((_buildMainButtons()));
      return Column(
        children: widgets,
      );
    }
  }

  void _executeChanges() {
    for (var entry in _modifiedIds.entries) {
      if (entry.value == ModifyWordgroupRow.uncommitedChanges) {
        //send double check message
      } else if (entry.value == ModifyWordgroupRow.markedForDelete) {
        widget.database.deleteWordgroupById(entry.key);
      } else if (entry.value == ModifyWordgroupRow.commited) {
        widget.database.updateWordgroup(_modifiedExistingGroups[entry.key]!);
      }
    }
    setState(() {
      _modifiedExistingGroups.clear();
      _modifiedIds.clear();
    });
  }

  void _resetAllChanges() {
    setState(() {
      _modifiedExistingGroups.clear();
      _modifiedIds.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return rowFutureBuilder<Wordgroup>(context,
        widget.database.queryAllWordgroups(), _buildExistingGroupsColumn);
  }
}
