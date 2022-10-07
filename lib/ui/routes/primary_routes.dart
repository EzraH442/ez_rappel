import 'package:ez_rappel/storage/tables.dart';
import 'package:flutter/material.dart';

import 'package:ez_rappel/pages/select_wordgroups_for_practice_page.dart';
import 'package:ez_rappel/pages/modify_wordgroups_page.dart';
import 'package:ez_rappel/pages/select_wordgroup_to_edit.dart';
import 'package:ez_rappel/pages/flashcard_page.dart';
import 'package:ez_rappel/pages/typing_practice_page.dart';
import 'package:ez_rappel/pages/edit_wordpairs_of_wordgroup_page.dart';

void pushPractice(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const PracticePage()));
}

void pushModifyWordpairs(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const ModifyWordsPage()));
}

void pushModifyTags(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const ModifyTagPage()));
}

void pushFlashcards(BuildContext context, Set<Tag> wgs) {
  Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) => FlashcardPage(selectedTags: wgs)));
}

void pushTypingPractice(BuildContext context, Set<Tag> wgs) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TypingPracticePage(selectedTags: wgs)));
}

void pushModifyWordpairsOfGroup(BuildContext context, int wgId) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditWordpairsOfTagPage(tagId: wgId)));
}
