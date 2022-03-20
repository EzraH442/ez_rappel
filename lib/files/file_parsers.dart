import 'dart:io';

import 'package:luples_flutter/words/data/entities/word_group.dart';
import 'package:luples_flutter/words/data/entities/word_pair.dart';

class WordpairFileParser {
  File file;

  WordpairFileParser(this.file);

  Future<List<Wordpair>> parse() async {
    final contents = await file.readAsLines();
    List<String> columns = contents[0].split(',');

    List<Wordpair> ret = [];

    for (int i = 0; i < columns.length; i++) {
      List<String> entry = contents[i].split(',');
      ret.add(Wordpair(
          id: int.parse(entry[0]),
          wordOne: entry[1],
          wordTwo: entry[2],
          languageOne: entry[3],
          languageTwo: entry[4]));
    }

    return ret;
  }
}

class WordgroupFileParser {
  File file;

  WordgroupFileParser(this.file);

  Future<List<Wordgroup>> parse() async {
    String date = DateTime.now().toIso8601String();

    final contents = await file.readAsLines();
    List<String> columns = contents[0].split(',');

    List<Wordgroup> ret = [];

    for (int i = 0; i < columns.length; i++) {
      List<String> entry = contents[i].split(',');
      ret.add(Wordgroup(
        id: int.parse(entry[0]),
        name: entry[1],
        languageOne: entry[2],
        languageTwo: entry[3],
        dateCreated: date,
      ));
    }

    return ret;
  }
}
