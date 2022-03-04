import 'dart:io';

import 'package:flutter/material.dart';
import 'package:luples_flutter/words/ui/app.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  if (Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const LanguageTupleApp());
}
