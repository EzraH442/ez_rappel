import 'dart:math';

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
  final Random _random = Random();
  late int _index = _random.nextInt(widget.wordpairs.length);

  void _onFlashcardTap() {
    setState(() {
      _flipped = !_flipped;
    });
  }

  void _onNextWordTap() {
    setState(() {
      _index = _random.nextInt(widget.wordpairs.length - 1);
      _flipped = _swapOrder;
    });
  }

  void _onCheckboxToggle(bool? toggled) {
    setState(() {
      _swapOrder = !_swapOrder;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Flashcard(
          onTap: _onFlashcardTap,
          word: _flipped
              ? widget.wordpairs[_index].wordTwo
              : widget.wordpairs[_index].wordOne),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(children: [
              const Text("Lang 1 word first?"),
              Checkbox(value: _swapOrder, onChanged: _onCheckboxToggle)
            ]),
          ),
          Container(
            child: TextButton(
                onPressed: _onNextWordTap, child: const Text("Next")),
          ),
        ],
      )
    ]);
  }
}
