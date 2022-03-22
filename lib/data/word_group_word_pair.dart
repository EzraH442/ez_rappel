import 'database_entity.dart';

class WordGroupWordPair extends DatabaseEntity {
  final int wordGroupId;
  final int wordPairId;

  const WordGroupWordPair({
    required this.wordGroupId,
    required this.wordPairId,
  });

  static const Map<String, String> columnNameMap = {
    "id": "rowid",
    "wordPairId": "word_pair_id",
    "wordGroupId": "word_group_id",
  };

  @override
  Map<String, dynamic> toMap() => {
        'wordPairId': wordPairId,
        'groupId': wordGroupId,
      };
}
