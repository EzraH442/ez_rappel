import 'dart:io';
import 'dart:async';

import 'package:file_picker/file_picker.dart';

import 'package:luples_flutter/database_utils.dart';

import 'file_parsers.dart';

class FileHelper {
  Future<File?> readlocalFileOrNull() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
    if (result != null) {
      return File(result.files.first.path!);
    } else {
      return null;
    }
  }

  Future<List<Wordpair>?> readWordpairFile(File f) async {
    final parser = WordpairFileParser(f);
    return parser.parse();
  }
}
