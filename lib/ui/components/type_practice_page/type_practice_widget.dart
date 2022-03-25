import 'dart:math';

import 'package:ez_rappel/ui/components/type_practice_page/text_practice_textfield.dart';
import 'package:flutter/material.dart';
import 'package:ez_rappel/database_utils.dart';

class TypePracticeWidget extends StatefulWidget {
  final List<Wordpair> wordpairs;
  const TypePracticeWidget({Key? key, required this.wordpairs})
      : super(key: key);

  @override
  State<TypePracticeWidget> createState() => _TypePracticeWidgetState();
}

class _TypePracticeWidgetState extends State<TypePracticeWidget> {
  bool _swapOrder = false;
  final Random _random = Random();
  late int _index = _random.nextInt(widget.wordpairs.length);
  int _correct = 0;
  int _total = 0;

  void _onWordSubmitted(bool correct) {
    setState(() {
      _total++;
      if (correct) {
        _correct++;
      }
    });
  }

  void _onNextWordTap() {
    setState(() {
      _index = _random.nextInt(widget.wordpairs.length - 1);
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
      TypePracticeTextfield(
          wp: widget.wordpairs[_index],
          swapOrder: _swapOrder,
          onSubmit: _onWordSubmitted),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "Score: $_correct / $_total: ${(_total == 0) ? 0 : ((_correct / _total) * 100).floor()}%"),
          Container(
            child: Row(children: [
              const Text("Lang 1 word given?"),
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
