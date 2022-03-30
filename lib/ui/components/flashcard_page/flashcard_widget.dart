import 'package:ez_rappel/algo/shuffle_wordpair_list.dart';
import 'package:ez_rappel/ui/components/flashcard_page/edit_wordpair_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ez_rappel/database_utils.dart';

import 'flashcard.dart';

class FlashcardWidget extends StatefulWidget {
  final List<Wordpair> wordpairs;
  const FlashcardWidget({Key? key, required this.wordpairs}) : super(key: key);

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool _flipped = false;
  bool _swapOrder = false;
  late int _index = 0;
  late final _wordpairs = List<Wordpair>.from(widget.wordpairs);

  void _onFlashcardTap() {
    setState(() {
      _flipped = !_flipped;
    });
  }

  void _onNextWordTap() {
    if (_index < _wordpairs.length - 1) {
      setState(() {
        _index++;
        _flipped = _swapOrder;
      });
    } else {
      setState(() {
        _index = 0;
      });
    }
  }

  void _onPreviousWordTap() {
    if (_index > 0) {
      setState(() {
        _index--;
        _flipped = _swapOrder;
      });
    } else {
      setState(() {
        _index = _wordpairs.length - 1;
      });
    }
  }

  void _onCheckboxToggle(bool? toggled) {
    setState(() {
      _swapOrder = !_swapOrder;
    });
  }

  void _onShuffle() {
    setState(() {
      shuffleList<Wordpair>(_wordpairs);
      _index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Container(
        padding: const EdgeInsets.all(8),
        child: Text("${(_index + 1).toString()} / ${_wordpairs.length}"),
      ),
      IntrinsicWidth(
        child: Column(children: [
          Flashcard(
              onTap: _onFlashcardTap,
              word: _flipped
                  ? _wordpairs[_index].wordTwo
                  : _wordpairs[_index].wordOne),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _onPreviousWordTap),
              IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: _onNextWordTap),
            ],
          ),
        ]),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Row(children: [
              const Text("Lang 1 word first?"),
              Checkbox(value: _swapOrder, onChanged: _onCheckboxToggle)
            ]),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: TextButton(
              child: const Text("Shuffle"),
              onPressed: _onShuffle,
            ),
          ),
        ],
      ),
      TextButton(
          onPressed: () async {
            Wordpair? result =
                await openEditWordpairDialog(context, _wordpairs[_index]);
            setState(() {
              if (result != null) {
                _wordpairs[_index] = result;
              }
            });
          },
          child: const Text("Edit current wordpair"))
    ]));
  }
}
