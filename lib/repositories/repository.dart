import 'dart:async';

import 'package:schedule_app/repositories/schedule_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  static final Repository _baseProvider = Repository._internal();

  Repository._internal();

  Database _db;
  Database get db => _db;

  static Future<Database> get() async {
    await _baseProvider.open();

    return _baseProvider.db;
  }

  Future open() async {
    if (_db != null) return;

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "app.db");

    var configRepository = ScheduleRepository();

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await configRepository.createTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await configRepository.updateTable(db);
      },
    );
  }
}
