import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastDBInit {
  static Future<Database> initSembast() async {
    const name = 'sembast_default_name.db';
    const version = 1;

    late Database db;
    if (kIsWeb) {
      final factory = databaseFactoryWeb;
      db = await factory.openDatabase(name);
    } else {
      final pathName = await _getDBPathWithName(name);

      final DatabaseFactory dbFactory = databaseFactoryIo;
      db = await dbFactory.openDatabase(pathName, version: version);
    }

    return db;
  }

  static Future<String> _getDBPathWithName(String name) async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    return '${dir.path}/$name';
  }
}
