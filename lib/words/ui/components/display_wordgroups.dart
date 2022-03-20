import 'package:flutter/material.dart';
import 'package:luples_flutter/words/data/entities/word_group.dart';
import 'package:luples_flutter/words/data/entities/word_pair.dart';
import 'package:luples_flutter/words/data/word_database_helper.dart';

wordgroupRowFutureBuilder(BuildContext ctx, WordDatabaseHelper db,
    Widget Function(List<Wordgroup>) buildColumn) {
  return FutureBuilder<List>(
    future: db.queryAllWordgroups(),
    builder: (context, snapshot) {
      return snapshot.hasData
          ? buildColumn(snapshot.data!.cast<Wordgroup>())
          : const Center(
              child: CircularProgressIndicator(),
            );
    },
  );
}

wordpairRowFutureBuilder(BuildContext ctx, WordDatabaseHelper db,
    Widget Function(List<Wordpair>) buildColumn) {
  return FutureBuilder<List>(
      future: db.queryAllWordgroups(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? buildColumn(snapshot.data!.cast<Wordpair>())
            : const Center(
                child: CircularProgressIndicator(),
              );
      });
}

modifyWordgroupRowFutureBuilder({
  required double width,
  required TextEditingController controller,
  required Color color,
  int? maxLength,
  String? labelText,
  void Function()? onEditingComplete,
}) {
  return Container(
    width: width,
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: TextField(
      controller: controller,
      maxLength: maxLength,
      style: TextStyle(color: color),
      decoration: InputDecoration(
        labelText: labelText,
      ),
      onEditingComplete: onEditingComplete,
    ),
  );
}

modifyWordpairRowTextfield({
  required TextEditingController controller,
  required Color color,
  String? labelText,
  void Function()? onEditingComplete,
}) {
  return Container(
    width: 100,
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: TextField(
      controller: controller,
      maxLength: 50,
      style: TextStyle(color: color),
      decoration: InputDecoration(
        labelText: labelText,
      ),
      onEditingComplete: onEditingComplete,
    ),
  );
}

mainTextButton(
    {required void Function() onPressed, required String buttonText}) {
  return TextButton(
      onPressed: onPressed, child: Text(buttonText, style: TextStyle()));
}
