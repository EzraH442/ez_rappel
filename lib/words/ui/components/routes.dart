import 'package:flutter/material.dart';

import 'package:luples_flutter/data/entities/word_group.dart';

import 'package:luples_flutter/words/ui/display_groups_page.dart';
import 'package:luples_flutter/words/ui/modify_groups_page.dart';
import 'package:luples_flutter/words/ui/select_groups.dart';
import 'package:luples_flutter/words/ui/flashcard_page.dart';

void pushPractice(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const PracticePage()));
}

void pushModifyWordpairs(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const ModifyWordsPage()));
}

void pushModifyWordgroups(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const ModifyWordgroupPage()));
}

void pushFlashcards(BuildContext context, Set<Wordgroup> wgs) {
  Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => FlashcardPage(selectedWordGroups: wgs)));
}
