import 'package:flutter/material.dart';

import 'edit_existing_words_section.dart';
import 'import_wordpair_page.dart';

class EditWordpairsOfWordgroupPage extends StatefulWidget {
  final int wordgroupId;

  const EditWordpairsOfWordgroupPage({Key? key, required this.wordgroupId})
      : super(key: key);

  @override
  State<EditWordpairsOfWordgroupPage> createState() =>
      _EditWordpairsOfWordgroupPageState();
}

class _EditWordpairsOfWordgroupPageState
    extends State<EditWordpairsOfWordgroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit wordpairs of wordgroup"),
      ),
      body: Column(children: [
        Container(
            child: ModifyExistingWordpairsSection(
                associatedWordgroupId: widget.wordgroupId)),
        ImportWordpairsToWordgroupSection(
            associatedWordgroupId: widget.wordgroupId),
      ]),
    );
  }
}
