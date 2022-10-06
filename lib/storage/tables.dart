import 'package:drift/drift.dart';

import 'dart:io';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'tables.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text()();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get user => integer()();
}

class Wordpairs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get first => text()();
  TextColumn get second => text()();
  IntColumn get user => integer()();
}

class WordpairTags extends Table {
  IntColumn get wpId => integer()();
  IntColumn get tagId => integer()();
}

@DriftDatabase(tables: [Users, Tags, Wordpairs, WordpairTags])
class Wordbase extends _$Wordbase {
  Wordbase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Tag>> get allTags => select(tags).get();
  Future<List<WordpairTag>> get allTagsByWordId => select(wordpairTags).get();
  Future<List<WordpairTag>> get allWordsByTagId => select(wordpairTags).get();

  Future<int> insertWordpair(Wordpair wp) {
    return into(wordpairs).insert(wp);
  }

  Future updateWordpair(Wordpair wp) {
    return (update(wordpairs)..whereSamePrimaryKey(wp)).write(
        WordpairsCompanion(first: Value(wp.first), second: Value(wp.second)));
  }

  Future<int> upsertWordpair(Wordpair wp) {
    return into(wordpairs).insertOnConflictUpdate(wp);
  }

  Future<void> insertMultipleWordpairs(List<Wordpair> wps) async {
    await batch((batch) {
      batch.insertAll(wordpairs, wps);
    });
  }

  Future<void> upsertMultipleWordpairs(List<Wordpair> wps) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(wordpairs, wps);
    });
  }

  Future<int> insertTag(Tag t) {
    return into(tags).insert(t);
  }

  Future<void> insertMultipleTags(List<Tag> ts) async {
    await batch((batch) {
      batch.insertAll(tags, ts);
    });
  }

  Future updateTag(Tag t) {
    return (update(tags)..whereSamePrimaryKey(t))
        .write(TagsCompanion(name: Value(t.name)));
  }

  Future<int> addWordpairToTag(WordpairTag wpt) {
    return into(wordpairTags).insert(wpt);
  }

  Future<void> addMultipleWordpairToTag(List<WordpairTag> wpts) async {
    await batch((batch) {
      batch.insertAll(wordpairTags, wpts);
    });
  }

  Future removeTagFromWordpair(int wpId, int tagId) {
    return (delete(wordpairTags)
          ..where((tbl) => tbl.wpId.equals(wpId))
          ..where((tbl) => tbl.tagId.equals(tagId)))
        .go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
