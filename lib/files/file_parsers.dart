import 'dart:io';

import 'package:ez_rappel/data/Exceptions/invalid_csv_header_exception.dart';
import 'package:ez_rappel/data/Exceptions/invalid_wordpair_csv_row_exception.dart';
import 'package:ez_rappel/database_utils.dart';

class WordpairFileParser {
  File file;

  WordpairFileParser(this.file);

  Future<List<Wordpair>> parse() async {
    final contents = await file.readAsLines();

    List<Wordpair> ret = [];

    List<String> columnNames = contents[0].split(',');

    if (!(columnNames[0] == 'id' &&
        columnNames[1] == "word_one" &&
        columnNames[2] == "word_two" &&
        columnNames[3] == "language_one" &&
        columnNames[4] == "language_two" && 
        columnNames.length == 5  
      )) {
      throw InvalidCSVHeaderException(contents[0]);
    }

    for (int i = 1; i < contents.length; i++) {
      List<String> entry = contents[i].split(',');
      if (entry.length > 5) {
        throw InvalidImportedWordpairException(
            contents[i], InvalidImportedWordpairException.extraColumn);
      }
      Wordpair imported = Wordpair(
          id: int.parse(entry[0]),
          wordOne: entry[1],
          wordTwo: entry[2],
          languageOne: entry[3],
          languageTwo: entry[4]);
      if (isWordpairValid(imported)) {
        ret.add(imported);
      }
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
