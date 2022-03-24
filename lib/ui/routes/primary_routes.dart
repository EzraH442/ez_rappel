import 'package:ez_rappel/ui/components/modify_words_of_group_page/edit_wordpairs_of_wordgroup.dart';
import 'package:flutter/material.dart';

import 'package:ez_rappel/database_utils.dart';

import 'package:ez_rappel/pages/display_groups_page.dart';
import 'package:ez_rappel/pages/modify_groups_page.dart';
import 'package:ez_rappel/pages/select_wordgroup_to_edit.dart';
import 'package:ez_rappel/pages/flashcard_page.dart';

void pushPractice(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const PracticePage()));
}

void pushModifyWordpairs(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const ModifyWordsPage()));
}

void pushModifyWordgroups(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) => const ModifyWordgroupPage()));
}

void pushFlashcards(BuildContext context, Set<Wordgroup> wgs) {
  Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) => FlashcardPage(selectedWordGroups: wgs)));
}

void pushModifyWordpairsOfGroup(BuildContext context, int wgId) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditWordpairsOfWordgroupPage(wordgroupId: wgId)));
}
