import 'package:luples_flutter/words/data/entities/word_group.dart';
import 'package:luples_flutter/words/data/entities/word_pair.dart';
import 'package:luples_flutter/words/data/entities/word_group_word_pair.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WordDatabaseHelper<WordPair> {
  static const _databaseName = "word.db";
  static const _databaseVersion = 1;
  static const _wordPairTableName = "word_pair_table";
  static const _wordGroupTableName = "word_group_table";
  static const _junctionTableName = "word_group_word_pair_table";
  static const _wordPairColumns = Wordpair.columnNameMap;
  static const _wordGroupColumns = Wordpair.columnNameMap;
  static const _junctionColumns = WordGroupWordPair.columnNameMap;

  static Database? _database;
  WordDatabaseHelper._privateConstructor();
  static final instance = WordDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _init();
    return _database!;
  }

  Future<Database> _init() async {
    return await openDatabase(
      join((await getApplicationDocumentsDirectory()).path, _databaseName),
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
         CREATE TABLE $_wordPairTableName (
           ${_wordPairColumns["id"]}           INTEGER PRIMARY KEY AUTOINCREMENT,
           ${_wordPairColumns["wordOne"]}      TEXT,
           ${_wordPairColumns["wordTwo"]}      TEXT,
           ${_wordPairColumns["languageOne"]}  TEXT,
           ${_wordPairColumns["languageTwo"]}  TEXT
         );
         ''');
    await db.execute('''
         CREATE TABLE $_wordGroupTableName (
           ${_wordGroupColumns["id"]}            INTEGER PRIMARY KEY AUTOINCREMENT,
           ${_wordGroupColumns["name"]}          TEXT,
           ${_wordGroupColumns["languageOne"]}   TEXT,
           ${_wordGroupColumns["languageTwo"]}   TEXT,
           ${_wordGroupColumns["dateCreated"]}   TEXT
         );
         ''');
    await db.execute('''
         CREATE TABLE $_junctionTableName (
           ${_junctionColumns["id"]}                                     INTEGER PRIMARY KEY AUTOINCREMENT,
           ${_junctionColumns["wordPairId"]}                             INTEGER,
           ${_junctionColumns["wordGroupId"]}                            INTEGER,
           FOREIGN KEY(${_junctionColumns["wordPairId"]}) 
            REFERENCES $_wordPairTableName(${_wordPairColumns["id"]})    ON DELETE CASCADE,
           FOREIGN KEY(${_junctionColumns["wordGroupId"]}) 
            REFERENCES $_wordGroupTableName(${_wordGroupColumns["id"]})  ON DELETE CASCADE
         );
       ''');
  }

  Future<List<Wordpair>> getWordsFromGroup(int groupId) async {
    Database db = await instance.database;

    String query = '''
      SELECT ${_wordPairColumns["wordOne"]}, ${_wordPairColumns["wordTwo"]} 
        FROM $_wordPairTableName
      JOIN $_junctionTableName 
        ON $_wordPairTableName.${_wordPairColumns["id"]} = ${_junctionColumns["wordPairId"]}
      JOIN $_wordGroupTableName 
        ON $_junctionTableName.word_group_id = $_wordGroupTableName.${_wordGroupColumns["id"]}
      WHERE $_wordGroupTableName.${_wordGroupColumns["id"]} = "$groupId" 
      ORDER BY ${_wordPairColumns["wordOne"]}, ${_wordPairColumns["wordTwo"]};
    ''';

    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return List.generate(
        maps.length,
        (i) => Wordpair(
              id: maps[i]['id'],
              wordOne: maps[i]['word_one'],
              wordTwo: maps[i]['word_two'],
              languageOne: maps[i]['language_one'],
              languageTwo: maps[i]['language_two'],
            ));
  }

  Future<List<Wordgroup>> queryAllWordgroups() async {
    Database db = await instance.database;

    final List<Map<String, dynamic>> maps =
        await db.query(_wordGroupTableName, columns: [
      _wordGroupColumns["id"]!,
      _wordGroupColumns["name"]!,
      _wordGroupColumns["languageOne"]!,
      _wordGroupColumns["languageTwo"]!,
      _wordGroupColumns["dateCreated"]!,
    ]);
    return List.generate(
        maps.length,
        (i) => Wordgroup(
              id: maps[i]['id'],
              name: maps[i]['name'],
              languageOne: maps[i]['language_one'],
              languageTwo: maps[i]['language_two'],
              dateCreated: maps[i]['date_created'],
            ));
  }

  Future<int> _insertWordpair(Wordpair wp, Database db) {
    return db.rawInsert('''
      INSERT INTO $_wordPairTableName(
        ${_wordPairColumns["word_one"]},
        ${_wordPairColumns["word_two"]},
        ${_wordPairColumns["language_one"]},
        ${_wordPairColumns["language_two"]}
      ) 
      VALUES(?, ?, ?, ?);
    ''', [
      wp.wordOne,
      wp.wordTwo,
      wp.languageOne,
      wp.languageTwo,
    ]);
  }

  Future<int> _insertWordgroup(Wordgroup wg, Database db) {
    return db.rawInsert('''
      INSERT INTO word_group_table(
        ${_wordGroupColumns["name"]},
        ${_wordGroupColumns["languageOne"]},
        ${_wordGroupColumns["languageTwo"]},
        ${_wordGroupColumns["dateCreated"]}
      )
      VALUES(?, ?, ?, ?);
      ''', [
      wg.name,
      wg.languageOne,
      wg.languageTwo,
      wg.dateCreated,
    ]);
  }

  Future<int> _addWordpairToGroup(int wordPairId, int groupID, Database db) {
    return db.rawInsert('''
      INSERT INTO $_junctionTableName(
        ${_junctionColumns["wordPairId"]},
        ${_junctionColumns["wordGroupId"]}
      )
      VALUES(
        $wordPairId,
        $groupID
      );
      ''');
  }

  Future<int> _updateWordpair(Wordpair wp, Database db) async {
    return db.rawUpdate('''
      UPDATE $_wordPairTableName 
      SET
        ${_wordPairColumns["wordOne"]} = "${wp.wordOne}",
        ${_wordPairColumns["wordTwo"]} = "${wp.wordTwo}",
        ${_wordPairColumns["languageOne"]} = "${wp.languageOne}",
        ${_wordPairColumns["languageTwo"]} = "${wp.languageTwo}"
      )
      WHERE ${_wordPairColumns["id"]} = ${wp.id}
    ''');
  }

  Future<int> _updateWordgroup(Wordgroup wg, Database db) async {
    return db.rawUpdate('''
      UPDATE $_wordGroupTableName
      SET
        ${_wordGroupColumns["name"]} = "${wg.name}",
        ${_wordGroupColumns["languageOne"]} = "${wg.languageOne}",
        ${_wordGroupColumns["languageTwo"]} = "${wg.languageTwo}"
      
      WHERE ${_wordGroupColumns["id"]} = ${wg.id}
    ''');
  }

  Future<int> _delteWord(Wordpair wg, Database db) async {
    return db.rawDelete(
        'DELETE FROM $_wordPairTableName WHERE ${_wordPairColumns["id"]} = ?',
        [wg.id]);
  }

  Future<int> _deleteJunctionEntry(
      int wordPairId, int wordGroupId, Database db) async {
    return db.rawDelete('''
      DELETE FROM $_junctionTableName 
      WHERE ${_wordPairColumns["id"]} = ? 
      AND ${_wordGroupColumns["id"]} = ?
    ''', [wordPairId, wordGroupId]);
  }

  Future<int> insertWord(Wordpair wp) async {
    return await _insertWordpair(wp, await instance.database);
  }

  Future<List<int>> insertAllWordpairs(List<Wordpair> wps) async {
    Database db = await instance.database;
    List<int> rowIDs = [];

    for (Wordpair wp in wps) {
      int rowID = await _insertWordpair(wp, db);
      rowIDs.add(rowID);
    }

    return rowIDs;
  }

  Future<int> insertWordgroup(Wordgroup wg) async {
    return await _insertWordgroup(wg, await instance.database);
  }

  Future<int> addWordpairToGroup(int wordPairId, int groupID) async {
    return await _addWordpairToGroup(
        wordPairId, groupID, await instance.database);
  }

  Future<List<int>> addAllWordpairsToGroup(
      List<int> wordPairIds, int groupId) async {
    Database db = await instance.database;
    List<int> rowIDs = [];

    for (int id in wordPairIds) {
      int rowId = await _addWordpairToGroup(id, groupId, db);
      rowIDs.add(rowId);
    }

    return rowIDs;
  }

  Future<int> updateWordpair(Wordpair wp) async {
    return _updateWordpair(wp, await instance.database);
  }

  Future<int> updateWordgroup(Wordgroup wg) async {
    return _updateWordgroup(wg, await instance.database);
  }

  Future<int> deleteWord(Wordpair wg, Database db) async {
    return _delteWord(wg, await instance.database);
  }

  Future<int> removeWordFromGroupWithIds(int wpId, int wgId) async {
    return _deleteJunctionEntry(wpId, wgId, await instance.database);
  }
  Future<int> removeWordFromGroup(Wordpair wp, Wordpair wg) async {
    return _deleteJunctionEntry(wp.id, wg.id, await instance.database);
  }
}
