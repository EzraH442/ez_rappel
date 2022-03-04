import 'package:luples_flutter/words/data/entities/database_entity.dart';

class Wordpair extends DatabaseEntity {
  final int id;
  final String wordOne;
  final String wordTwo;
  final String languageOne;
  final String languageTwo;

  const Wordpair({
    required this.id,
    required this.wordOne,
    required this.wordTwo,
    required this.languageOne,
    required this.languageTwo,
  });

  static const Map<String, String> columnNameMap = {
    "id": "id",
    "wordOne": "word_one",
    "wordTwo": "word_two",
    "languageOne": "language_one",
    "languageTwo": "language_two"
  };

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'word_one': wordOne,
        'word_two': wordTwo,
        'language_one': languageOne,
        "language_two": languageTwo
      };
}
