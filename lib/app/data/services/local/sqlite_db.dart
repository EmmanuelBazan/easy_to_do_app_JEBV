import 'dart:io';

import 'package:easy_to_do_app/app/domain/models/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class SqliteDB {
  static Database? _database;

  Future<Database> get getDB async {
    if (_database != null) return _database!;

    _database = await _initDB();

    return _database!;
  }

  Future<Database> _initDB() async {
    //^ Path where the database will be stored
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'EasyToDoApp.db');

    //^ Create database
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE TaskImages(
            id INTEGER PRIMARY KEY,
            uri1 TEXT,
            uri2 TEXT,
            uri3 TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE Tasks(
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            done REAL,
            priority TEXT,
            creationDate TEXT,
            imagesId INT,
            FOREIGN KEY (imagesId) REFERENCES TaskImages (id) ON DELETE SET NULL ON UPDATE NO ACTION
          )
        ''');
      },
    );
  }

  Future<List<TaskModel>> getAllTasks(Database db) async {
    final res = await db.query('Tasks');

    return res.isNotEmpty ? res.map((e) => TaskModel.fromMap(e)).toList() : [];
  }

  Future<List<TaskModel>> getTasksByDate(Database db, String date) async {
    final res =
        await db.query('Tasks', where: 'creationDate = ?', whereArgs: [date]);

    return res.isNotEmpty ? res.map((e) => TaskModel.fromMap(e)).toList() : [];
  }

  Future<TaskModel?> createTask(Database db, TaskModel task) async {
    try {
      final res = await db.insert('Tasks', task.toMap());
      task.id = res;
      return task;
    } catch (e) {
      print('ERROR INSER TASK: $e');
      return null;
    }
  }

  Future<TaskModel?> updateTask(Database db, TaskModel task) async {
    try {
      await db.update('Tasks', {'done': task.done ? 1 : 0},
          where: 'id = ?', whereArgs: [task.id]);
      return task;
    } catch (e) {
      print('ERROR UPDATE TASK: $e');
      return null;
    }
  }

  Future<int?> deleteTask(Database db, int taskId) async {
    try {
      final res =
          await db.delete('Tasks', where: 'id = ?', whereArgs: [taskId]);
      return res;
    } catch (e) {
      print('ERROR DELETE TASK: $e');
      return null;
    }
  }
}
