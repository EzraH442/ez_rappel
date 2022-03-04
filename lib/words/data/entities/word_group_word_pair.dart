import 'package:luples_flutter/words/data/entities/database_entity.dart';

class WordGroupWordPair extends DatabaseEntity {
  final int wordGroupId;
  final int wordPairId;

  const WordGroupWordPair({
    required this.wordGroupId,
    required this.wordPairId,
  });

  static const Map<String, String> columnNameMap = {
    "id": "id",
    "wordGroupId": "word_group_id",
    "wordPairId": "word_pair_id",
  };

  @override
  Map<String, dynamic> toMap() => {
        'groupId': wordGroupId,
        'wordPairId': wordPairId,
      };
}
