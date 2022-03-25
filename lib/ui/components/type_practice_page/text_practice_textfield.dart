import 'package:flutter/material.dart';
import 'package:ez_rappel/database_utils.dart';

class TypePracticeTextfield extends StatefulWidget {
  final Wordpair wp;
  final bool swapOrder;
  final void Function(bool correct) onSubmit;
  const TypePracticeTextfield(
      {Key? key,
      required this.wp,
      required this.swapOrder,
      required this.onSubmit})
      : super(key: key);

  @override
  State<TypePracticeTextfield> createState() => _TypePracticeTextfieldState();
}

class _TypePracticeTextfieldState extends State<TypePracticeTextfield> {
  static const unsubmitted = 0;
  static const correct = 1;
  static const incorrect = 2;

  int _status = unsubmitted;
  final _textController = TextEditingController();

  void _onSubmit(String val) {
    int newStatus;
    if (val == (widget.swapOrder ? widget.wp.wordOne : widget.wp.wordTwo)) {
      newStatus = correct;
    } else {
      newStatus = incorrect;
    }
    setState(() {
      _status = newStatus;
      widget.onSubmit((newStatus == correct));
    });
  }

  Color _decideColor() {
    switch (_status) {
      case unsubmitted:
        return Colors.black;
      case correct:
        return Colors.green;
      case incorrect:
        return Colors.red;
    }
    return Colors.brown;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        height: 200,
        child: Column(children: [
          Text(
            widget.swapOrder ? widget.wp.wordTwo : widget.wp.wordOne,
            style: TextStyle(color: _decideColor()),
          ),
          TextField(
            controller: _textController,
            onSubmitted: _onSubmit,
          ),
        ]));
  }
}
