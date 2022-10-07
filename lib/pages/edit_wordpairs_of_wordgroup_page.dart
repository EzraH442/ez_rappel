import 'package:flutter/material.dart';
import 'package:ez_rappel/page_components.dart';

class EditWordpairsOfTagPage extends StatefulWidget {
  final int tagId;

  const EditWordpairsOfTagPage({Key? key, required this.tagId})
      : super(key: key);

  @override
  State<EditWordpairsOfTagPage> createState() => _EditWordpairsOfTagPageState();
}

class _EditWordpairsOfTagPageState extends State<EditWordpairsOfTagPage> {
  void _notifyChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit wordpairs of tag"),
        ),
        body: Column(
          children: [
            ModifyExistingWordpairsSection(associatedTagId: widget.tagId),
            Expanded(
              child: ImportWordpairsToTagSection(
                  tagId: widget.tagId, notifyWordsAdded: _notifyChange),
            )
          ],
        ));
  }
}
