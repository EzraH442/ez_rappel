import 'package:flutter/material.dart';
import 'package:luples_flutter/words/data/entities/word_pair.dart';

import 'package:luples_flutter/words/data/word_database_helper.dart';
import 'package:luples_flutter/words/ui/components/display_wordgroups.dart';
import 'edit_existing_words_row.dart';

class ModifyExistingWordpairsSection extends StatefulWidget {
  final int associatedWordgroupId;
  final WordDatabaseHelper database;
  const ModifyExistingWordpairsSection({
    Key? key,
    required this.associatedWordgroupId,
    required this.database,
  }) : super(key: key);

  @override
  State<ModifyExistingWordpairsSection> createState() =>
      _ModifyExistingWordpairsSectionState();
}

class _ModifyExistingWordpairsSectionState
    extends State<ModifyExistingWordpairsSection> {
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

  Widget _buildExistingPairsColumn(List<Wordpair> wps) {
    return Column(
        children: wps.map((wp) {
      if (_modifiedIds.containsKey(wp.id)) {
        return ModifyWordpairRow(
          wordpairId: wp.id,
          oldValues: wp,
          notifyStatusChange: _notifyExistingWordpairStatusChange,
          removeFromModified: _removeFromExisitingWordpairsModified,
          commitChanges: _addToModifiedExistingPairs,
        );
      } else {
        return ListTile(
            leading: Container(
                child: Row(children: [Text(wp.wordOne), Text(wp.wordTwo)])),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _modifiedIds[wp.id] = ModifyWordpairRow.unchanged;
                });
              },
            ));
      }
    }).toList());
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
        widget.database.removeWordFromGroupWithIds(entry.key, widget.associatedWordgroupId);
      } else if (entry.value == ModifyWordpairRow.commited) {
        widget.database.updateWordpair(_modifiedExistingPairs[entry.key]!);
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
    return Column(
      children: [
        wordpairRowFutureBuilder(
            context, widget.database, _buildExistingPairsColumn),
        _buildMainButtons(),
      ],
    );
  }
}
