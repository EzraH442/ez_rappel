import 'package:luples_flutter/data/entities/database_entity.dart';

class Wordgroup extends DatabaseEntity {
  final int id;
  final String name;
  final String languageOne;
  final String languageTwo;
  final String dateCreated;

  const Wordgroup({
    required this.id,
    required this.name,
    required this.languageOne,
    required this.languageTwo,
    required this.dateCreated,
  });

  static const Map<String, String> columnNameMap = {
    "id": "id",
    "name": "name",
    "languageOne": "language_one",
    "languageTwo": "language_two",
    "dateCreated": "date_created",
  };

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'language_one': languageOne,
        'language_two': languageTwo,
        'date_created': dateCreated,
      };

  @override
  bool operator ==(Object other) {
    if (other is Wordgroup) {
      return (other.id == id &&
          other.name == name &&
          other.languageOne == languageOne &&
          other.languageTwo == languageTwo &&
          other.dateCreated == dateCreated);
    }
    return false;
  }

  @override
  int get hashCode => id.hashCode;
}
