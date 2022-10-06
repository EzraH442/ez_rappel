import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';

class TypePracticeTextfield extends StatefulWidget {
  final Wordpair wp;
  final bool swapOrder;
  final TextEditingController tec;
  final void Function(String val) onSubmit;
  final int status;
  const TypePracticeTextfield({
    Key? key,
    required this.wp,
    required this.swapOrder,
    required this.tec,
    required this.onSubmit,
    required this.status,
  }) : super(key: key);

  @override
  State<TypePracticeTextfield> createState() => _TypePracticeTextfieldState();
}

class _TypePracticeTextfieldState extends State<TypePracticeTextfield> {
  Color _decideColor() {
    switch (widget.status) {
      case 0:
        return Colors.black;
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
    }
    return Colors.brown;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 300,
      child: Column(
        children: [
          Text(
            widget.swapOrder ? widget.wp.first : widget.wp.second,
            style: TextStyle(color: _decideColor()),
          ),
          TextField(
            controller: widget.tec,
            onSubmitted: widget.onSubmit,
            style: TextStyle(color: _decideColor()),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              height: 50,
              child: Text((widget.status == 2)
                  ? "The corrent answer was: ${widget.swapOrder ? widget.wp.first : widget.wp.second}"
                  : "")),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.black,
        width: 1,
      )),
    );
  }
}
