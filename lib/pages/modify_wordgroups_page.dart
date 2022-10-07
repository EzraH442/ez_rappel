import 'package:flutter/material.dart';
import 'package:ez_rappel/page_components.dart';

class ModifyTagPage extends StatefulWidget {
  const ModifyTagPage({Key? key}) : super(key: key);

  @override
  State<ModifyTagPage> createState() => _ModifyTagPageState();
}

class _ModifyTagPageState extends State<ModifyTagPage> {
  void _notifyExistingGroupsSection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Modify Tags"),
        ),
        body: Column(
          children: [
            const ModifyExistingTagsSection(),
            AddNewTagSection(notifyExecution: _notifyExistingGroupsSection),
          ],
        ));
  }
}
