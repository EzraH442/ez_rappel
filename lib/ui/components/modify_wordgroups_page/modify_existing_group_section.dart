import 'package:ez_rappel/main.dart';
import 'package:ez_rappel/storage/tables.dart';
import 'package:ez_rappel/ui/components/modify/button_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../display_wordgroups.dart';
import 'modify_existing_group_row.dart';

class ModifyExistingTagsSection extends StatefulWidget {
  const ModifyExistingTagsSection({
    Key? key,
  }) : super(key: key);

  @override
  State<ModifyExistingTagsSection> createState() =>
      _ModifyExistingTagsSectionState();
}

class _ModifyExistingTagsSectionState extends State<ModifyExistingTagsSection> {
  final _modifiedIdsStatus = <int, int>{};
  final modifiedTags = <int, Tag>{};

  _notifyExistingTagStatusChange(int id, int status) {
    setState(() {
      _modifiedIdsStatus[id] = status;
    });
  }

  _removeFromExisitingTagsModified(int id) {
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
          child: Text("Add your first tag below!"),
        )
      ]);
    } else {
      List<Widget> widgets = [];
      widgets.addAll(tags.map((wg) {
        if (_modifiedIdsStatus.containsKey(wg.id)) {
          return ModifyTagpRow(
            id: wg.id,
            oldValues: wg,
            notifyStatusChange: _notifyExistingTagStatusChange,
            removeFromModified: _removeFromExisitingTagsModified,
            commitChanges: _addToModifiedExistingGroups,
          );
        } else {
          return ListTile(
            leading: Text(wg.name),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () =>
                  _notifyExistingTagStatusChange(wg.id, EditRow.unchanged),
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
      if (entry.value == EditRow.uncommitedChanges) {
        //send double check message
      } else if (entry.value == EditRow.markedForDelete) {
        // widget.database.deleteWordgroupById(entry.key);
      } else if (entry.value == EditRow.commited) {
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
