import 'package:flutter/material.dart';
import 'package:ez_rappel/database_utils.dart';
import 'package:ez_rappel/page_components.dart';

class ModifyWordgroupPage extends StatefulWidget {
  const ModifyWordgroupPage({Key? key}) : super(key: key);

  @override
  State<ModifyWordgroupPage> createState() => _ModifyWordgroupPageState();
}

class _ModifyWordgroupPageState extends State<ModifyWordgroupPage> {
  final _db = WordDatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ModifyExistingWordgroupsSection(database: _db),
        AddNewWordgroupSection(database: _db),
      ],
    ));
  }
}
