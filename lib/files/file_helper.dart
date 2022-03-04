import 'dart:io';
import 'dart:async';

import 'package:file_picker/file_picker.dart';

class FileHelper {
  Future<File?> get _localFileOrNull async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
    if (result != null) {
      return File(result.files.first.path!);
    } else {
      return null;
    }
  }

  void readFileAndAddCone(File f) async {
    try {
      final contents = await f.readAsLines();
    } catch (e) {
      return;
    }
  }
}
