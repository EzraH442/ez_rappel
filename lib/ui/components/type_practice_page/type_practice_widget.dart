import 'dart:math';

import 'package:ez_rappel/ui/components/type_practice_page/accent_info_table.dart';
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
  static const unsubmitted = 0;
  static const correct = 1;
  static const incorrect = 2;

  final Random _random = Random();
  final _tec = TextEditingController();
  late int _index = _random.nextInt(widget.wordpairs.length);

  bool _swapOrder = false;
  bool _submitted = false;
  int _correct = 0;
  int _total = 0;
  int _status = unsubmitted;

  void _onWordSubmitted(String val) {
    if (!_submitted) {
      int newStatus;
      if (val ==
          (_swapOrder
              ? widget.wordpairs[_index].wordOne
              : widget.wordpairs[_index].wordTwo)) {
        newStatus = correct;
      } else {
        newStatus = incorrect;
      }
      setState(() {
        _submitted = true;
        _status = newStatus;
        _total++;
        if ((_status == correct)) {
          _correct++;
        }
      });
    } else {
      _onNextWordTap();
    }
  }

  void _onNextWordTap() {
    setState(() {
      _index = _random.nextInt(widget.wordpairs.length - 1);
      _status = unsubmitted;
      _submitted = false;
    });
    _tec.clear();
  }

  void _onCheckboxToggle(bool? toggled) {
    setState(() {
      _swapOrder = !_swapOrder;
    });
  }

  @override
  void dispose() {
    _tec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: 40,
          child: Center(
            child: Text(
                "Score: $_correct / $_total: ${(_total == 0) ? 0 : ((_correct / _total) * 100).floor()}%"),
          )),
      TypePracticeTextfield(
        wp: widget.wordpairs[_index],
        swapOrder: _swapOrder,
        tec: _tec,
        onSubmit: _onWordSubmitted,
        status: _status,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            const Text("Lang 1 word given?"),
            Checkbox(value: _swapOrder, onChanged: _onCheckboxToggle)
          ]),
          TextButton(onPressed: _onNextWordTap, child: const Text("Next")),
        ],
      ),
      const AccentInfoSection(),
    ]);
  }
}
