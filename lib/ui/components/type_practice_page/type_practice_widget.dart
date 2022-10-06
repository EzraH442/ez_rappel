import 'package:ez_rappel/algo/shuffle_wordpair_list.dart';
import 'package:ez_rappel/storage/tables.dart';
import 'package:ez_rappel/ui/components/type_practice_page/accent_info_table.dart';
import 'package:ez_rappel/ui/components/type_practice_page/text_practice_textfield.dart';
import 'package:flutter/material.dart';

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

  final _tec = TextEditingController();
  late final List<Wordpair> _wordpairs = List.from(widget.wordpairs);
  final List<int> correctIds = [];
  final List<int> incorrectIds = [];

  int _index = 0;
  int _correct = 0;
  bool _swapOrder = false;
  bool _submitted = false;
  int _total = 0;
  int _status = unsubmitted;

  void _onWordSubmitted(String val) {
    if (!_submitted) {
      int newStatus;
      if (val ==
          (_swapOrder ? _wordpairs[_index].first : _wordpairs[_index].second)) {
        newStatus = correct;
      } else {
        newStatus = incorrect;
      }
      setState(() {
        _submitted = true;
        _status = newStatus;
        _total++;
        if (_status == correct) {
          correctIds.add(_wordpairs[_index].id);
          _correct++;
        } else {
          incorrectIds.add(_wordpairs[_index].id);
        }
      });
    } else {
      _onNextWordTap();
    }
  }

  void _onNextWordTap() {
    if (_submitted) {
      setState(() {
        _status = unsubmitted;
        _submitted = false;
        if (_index < _wordpairs.length - 1) {
          _index++;
        }
      });
      _tec.clear();
    }
  }

  void _onCheckboxToggle(bool? toggled) {
    setState(() {
      _swapOrder = !_swapOrder;
    });
  }

  void _onRestart() {
    setState(() {
      shuffleList<Wordpair>(_wordpairs);
      _index = 0;
      _swapOrder = false;
      _submitted = false;
      _correct = 0;
      _total = 0;
      _status = unsubmitted;
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
        wp: _wordpairs[_index],
        swapOrder: _swapOrder,
        tec: _tec,
        onSubmit: _onWordSubmitted,
        status: _status,
      ),
      Container(
          width: 300,
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: _onNextWordTap,
              icon: const Icon(Icons.arrow_forward))),
      SizedBox(
        width: 300,
        child: ListTile(
          leading: const Text("Lang 1 word given?"),
          trailing: Checkbox(value: _swapOrder, onChanged: _onCheckboxToggle),
        ),
      ),
      SizedBox(
          width: 300,
          child: TextButton(
            child: const Text("Shuffle and Restart"),
            onPressed: _onRestart,
          )),
      const AccentInfoSection(),
    ]);
  }
}
