import 'package:flutter/material.dart';
import 'package:luples_flutter/database_utils.dart';
import 'package:luples_flutter/words/ui/components/modfy_group_page/add_new_wordgroups_fragment/add_new_group_section.dart';
import 'package:luples_flutter/words/ui/components/modfy_group_page/modify_existing_group_fragment/modify_existing_group_section.dart';

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
