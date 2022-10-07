import 'package:ez_rappel/main.dart';
import 'package:ez_rappel/storage/tables.dart';
import 'package:ez_rappel/ui/components/modify/button_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../display_wordgroups.dart';
import 'edit_existing_words_row.dart';

class ModifyExistingWordpairsSection extends StatefulWidget {
  final int associatedTagId;
  const ModifyExistingWordpairsSection({
    Key? key,
    required this.associatedTagId,
  }) : super(key: key);

  @override
  State<ModifyExistingWordpairsSection> createState() =>
      _ModifyExistingWordpairsSectionState();
}

class _ModifyExistingWordpairsSectionState
    extends State<ModifyExistingWordpairsSection> {
  final _modifiedIdsStatus = <int, int>{};
  final _modifiedExistingPairs = <int, Wordpair>{};

  _notifyExistingWordpairStatusChange(int id, int status) {
    setState(() {
      _modifiedIdsStatus[id] = status;
    });
  }

  _removeFromExisitingWordpairsModified(int id) {
    setState(() {
      _modifiedIdsStatus.remove(id);
      _modifiedExistingPairs.remove(id);
    });
  }

  _addToModifiedExistingPairs(Wordpair wp) {
    setState(() {
      _modifiedExistingPairs[wp.id] = wp;
    });
  }

  ListView _buildExistingPairsColumn(List<Wordpair> wps) {
    return ListView(
        controller: ScrollController(),
        children: wps
            .map((wp) => _modifiedIdsStatus.containsKey(wp.id)
                ? ModifyWordpairRow(
                    id: wp.id,
                    oldValues: wp,
                    notifyStatusChange: _notifyExistingWordpairStatusChange,
                    removeFromModified: _removeFromExisitingWordpairsModified,
                    commitChanges: _addToModifiedExistingPairs,
                  )
                : Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                Expanded(
                                  child: Text(wp.first),
                                ),
                                Expanded(
                                  child: Text(wp.second),
                                ),
                              ])),
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _notifyExistingWordpairStatusChange(
                                      wp.id, EditRow.unchanged)),
                        ])))
            .toList());
  }

  Row _buildMainButtons() {
    return Row(children: [
      MainTextButton(onPressed: _executeChanges, buttonText: "Confirm"),
      MainTextButton(onPressed: _resetAllChanges, buttonText: "Cancel"),
    ]);
  }

  void _executeChanges() {
    final db = context.read<AppContext>().db;
    for (var entry in _modifiedIdsStatus.entries) {
      if (entry.value == EditRow.uncommitedChanges) {
        //send double check message
      } else if (entry.value == EditRow.markedForDelete) {
        // _db.removeWordFromGroupWithIds(entry.key, widget.associatedWordgroupId);
      } else if (entry.value == EditRow.commited) {
        // _db.updateWordpair(_modifiedExistingPairs[entry.key]!);
      }
    }
    setState(() {
      _modifiedExistingPairs.clear();
      _modifiedIdsStatus.clear();
    });
  }

  void _resetAllChanges() {
    setState(() {
      _modifiedExistingPairs.clear();
      _modifiedIdsStatus.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppContext>().db;
    return Flexible(
      child: Column(
        children: [
          Flexible(
            child: rowFutureBuilder<Wordpair>(
                context,
                db.allWordsFromTagId(widget.associatedTagId),
                _buildExistingPairsColumn),
          ),
          SizedBox(child: _buildMainButtons(), height: 50),
        ],
      ),
    );
  }
}
