import 'dart:async';

import 'package:schedule_app/models/schedule_model.dart';
import 'package:schedule_app/repositories/repository.dart';
import 'package:sqflite/sqflite.dart';

import 'i_repository.dart';

class ScheduleRepository implements IRepository {
  static final String tableName = "Schedule";
  static final String columnId = "id";
  static final String columnStartDate = "startDate";
  static final String columnEndDate = "endDate";
  static final String columnDescription = "description";
  static final String columnOk = "ok";

  Future<Database> get dbClient async => await Repository.get();

  @override
  Future createTable(Database db) async {
    try {
      await db.execute(
          "CREATE TABLE $tableName ($columnId TEXT primary key, $columnStartDate TEXT, $columnEndDate TEXT, $columnDescription TEXT, $columnOk TEXT)");
    } catch (e) {
      print('error: create table $tableName\n${e.toString()}');
    }
  }

  @override
  Future updateTable(Database db) {
    return null;
  }

  Future<List<ScheduleModel>> getList() async {
    List<ScheduleModel> lista = List();
    try {
      final _db = await dbClient;

      var maps = await _db.query(tableName, columns: [
        columnId,
        columnStartDate,
        columnEndDate,
        columnDescription,
        columnOk
      ]);

      if (maps.length > 0) {
        for (var item in maps) {
          lista.add(ScheduleModel.fromJson(item));
        }
      }
    } catch (e) {
      print('error: get Schedule list $tableName\n${e.toString()}');
      return null;
    }
    return lista;
  }

  Future<ScheduleModel> getObject(String key) async {
    ScheduleModel obj;
    try {
      final _db = await dbClient;

      var maps = await _db.query(tableName,
          columns: [
            columnId,
            columnStartDate,
            columnEndDate,
            columnDescription,
            columnOk
          ],
          where: "id=?",
          whereArgs: [key]);

      if (maps.length > 0) {
        var mapObj = maps.first;
        obj = ScheduleModel.fromJson(mapObj);
      }
    } catch (e) {
      print('error: get Schedule $tableName\n${e.toString()}');
    }
    return obj;
  }

  Future updateObject(String key, obj) async {
    try {
      final _db = await dbClient;

      String startDate = '';
      if (obj.startDate != null) {
        startDate = obj.startDate.toIso8601String();
      }

      String endDate = '';
      if (obj.endDate != null) {
        endDate = obj.endDate.toIso8601String();
      }

      String ok = 'false';
      if (obj.ok != null) {
        ok = obj.ok.toString();
      }

      await _db.rawUpdate(
          'update $tableName set $columnStartDate=?, $columnEndDate=?, $columnDescription=?, $columnOk=? where id=?',
          [startDate, endDate, obj.description, ok, obj.id]);
    } catch (e) {
      print('error: update Schedule $tableName\n${e.toString()}');
      throw e;
    }
    return obj;
  }

  Future insertObject(obj) async {
    try {
      final _db = await dbClient;

      String startDate = '';
      if (obj.startDate != null) {
        startDate = obj.startDate.toIso8601String();
      }

      String endDate = '';
      if (obj.endDate != null) {
        endDate = obj.endDate.toIso8601String();
      }

      String ok = 'false';
      if (obj.ok != null) {
        ok = obj.ok.toString();
      }

      await _db.rawUpdate(
          'insert into  $tableName($columnId, $columnStartDate, $columnEndDate, $columnDescription, $columnOk) values (?,?,?,?,?)',
          [obj.id, startDate, endDate, obj.description, ok]);
    } catch (e) {
      print('error: insert Schedule $tableName\n${e.toString()}');
      throw e;
    }
    return obj;
  }

  Future deleteObject(String key) async {
    try {
      final _db = await dbClient;

      await _db.rawDelete('delete from $tableName where id=?', [key]);
    } catch (e) {
      print('error: delete Schedule $tableName\n${e.toString()}');
      throw e;
    }
    return true;
  }

  Future clean() async {
    try {
      final _db = await dbClient;

      await _db.rawDelete('delete from $tableName');
    } catch (e) {
      print('error: clean Schedule $tableName\n${e.toString()}');
      throw e;
    }

    return true;
  }
}
