import 'package:ez_rappel/main.dart';
import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../display_wordgroups.dart';
import 'modify_existing_group_row.dart';

class ModifyExistingWordgroupsSection extends StatefulWidget {
  const ModifyExistingWordgroupsSection({
    Key? key,
  }) : super(key: key);

  @override
  State<ModifyExistingWordgroupsSection> createState() =>
      _ModifyExistingWordgroupsSectionState();
}

class _ModifyExistingWordgroupsSectionState
    extends State<ModifyExistingWordgroupsSection> {
  final _modifiedIdsStatus = <int, int>{};
  final modifiedTags = <int, Tag>{};

  _notifyExistingWordgroupStatusChange(int id, int status) {
    setState(() {
      _modifiedIdsStatus[id] = status;
    });
  }

  _removeFromExisitingWordgroupsModified(int id) {
    setState(() {
      _modifiedIdsStatus.remove(id);
      modifiedTags.remove(id);
    });
  }

  _addToModifiedExistingGroups(Tag t) {
    setState(() {
      modifiedTags[t.id] = t;
    });
  }

  Row _buildMainButtons() {
    return Row(
      children: [
        ConfirmButton(onPressed: _executeChanges),
        CancelButton(onPressed: _resetAllChanges),
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  }

  Column _buildExistingGroupsColumn(List<Tag> tags) {
    if (tags.isEmpty) {
      return Column(children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Add your first wordgroup below!"),
        )
      ]);
    } else {
      List<Widget> widgets = [];
      widgets.addAll(tags.map((wg) {
        if (_modifiedIdsStatus.containsKey(wg.id)) {
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
    final db = context.read<AppContext>().db;
    for (var entry in _modifiedIdsStatus.entries) {
      if (entry.value == ModifyWordgroupRow.uncommitedChanges) {
        //send double check message
      } else if (entry.value == ModifyWordgroupRow.markedForDelete) {
        // widget.database.deleteWordgroupById(entry.key);
      } else if (entry.value == ModifyWordgroupRow.commited) {
        db.updateTag(modifiedTags[entry.key]!);
      }
    }
    setState(() {
      modifiedTags.clear();
      _modifiedIdsStatus.clear();
    });
  }

  void _resetAllChanges() {
    setState(() {
      modifiedTags.clear();
      _modifiedIdsStatus.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppContext>().db;
    return rowFutureBuilder<Tag>(
        context, db.allTags, _buildExistingGroupsColumn);
  }
}
