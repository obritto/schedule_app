import 'package:sqflite/sqflite.dart';

abstract class IRepository {
  Future<dynamic> createTable(Database db);
  Future<dynamic> updateTable(Database db);

  Future<dynamic> getList();
  Future<dynamic> getObject(String key);
  Future<dynamic> updateObject(String key, dynamic obj);
  Future<dynamic> insertObject(dynamic obj);
  Future<dynamic> deleteObject(String key);

  Future<dynamic> clean();
}
