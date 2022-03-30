import 'package:flutter/material.dart';
import 'package:ez_rappel/database_utils.dart';
import '../display_wordgroups.dart';
import 'edit_existing_words_row.dart';

class ModifyExistingWordpairsSection extends StatefulWidget {
  final int associatedWordgroupId;
  const ModifyExistingWordpairsSection({
    Key? key,
    required this.associatedWordgroupId,
  }) : super(key: key);

  @override
  State<ModifyExistingWordpairsSection> createState() =>
      _ModifyExistingWordpairsSectionState();
}

class _ModifyExistingWordpairsSectionState
    extends State<ModifyExistingWordpairsSection> {
  final _db = WordDatabaseHelper.instance;

  final _modifiedIds = <int, int>{};
  final _modifiedExistingPairs = <int, Wordpair>{};

  _notifyExistingWordpairStatusChange(int id, int status) {
    setState(() {
      _modifiedIds[id] = status;
    });
  }

  _removeFromExisitingWordpairsModified(int id) {
    setState(() {
      _modifiedIds.remove(id);
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
            .map((wp) => _modifiedIds.containsKey(wp.id)
                ? ModifyWordpairRow(
                    wordpairId: wp.id,
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
                                  child: Text(wp.wordOne),
                                ),
                                Expanded(
                                  child: Text(wp.wordTwo),
                                ),
                              ])),
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _notifyExistingWordpairStatusChange(
                                      wp.id, ModifyWordpairRow.unchanged)),
                        ])))
            .toList());
  }

  Row _buildMainButtons() {
    return Row(children: [
      mainTextButton(onPressed: _executeChanges, buttonText: "Confirm"),
      mainTextButton(onPressed: _resetAllChanges, buttonText: "Cancel"),
    ]);
  }

  void _executeChanges() {
    for (var entry in _modifiedIds.entries) {
      if (entry.value == ModifyWordpairRow.uncommitedChanges) {
        //send double check message
      } else if (entry.value == ModifyWordpairRow.markedForDelete) {
        _db.removeWordFromGroupWithIds(entry.key, widget.associatedWordgroupId);
      } else if (entry.value == ModifyWordpairRow.commited) {
        _db.updateWordpair(_modifiedExistingPairs[entry.key]!);
      }
    }
    setState(() {
      _modifiedExistingPairs.clear();
      _modifiedIds.clear();
    });
  }

  void _resetAllChanges() {
    setState(() {
      _modifiedExistingPairs.clear();
      _modifiedIds.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Flexible(
            child: rowFutureBuilder<Wordpair>(
                context,
                _db.getWordsFromGroup(widget.associatedWordgroupId),
                _buildExistingPairsColumn),
          ),
          SizedBox(child: _buildMainButtons(), height: 50),
        ],
      ),
    );
  }
}
