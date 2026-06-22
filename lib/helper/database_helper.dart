import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/todo_model.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> getDB() async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      version: 3,
      onCreate: (db, version) async {
        // table create garnalai
        db.execute(
          'CREATE TABLE Todo (id INTEGER PRIMARY KEY, title TEXT,description TEXT)',
        );
      },

      // database upgrade garnalai
      // onUpgrade: (db, oldVersion, newVersion) {

      // },
    );
    return _database!;
  }

  static Future<int> insertToDo(TodoModel todo) async {
    final db = await getDB();
    return await db.insert('Todo', todo.toMap());
  }

  // get todo

  static Future<List<TodoModel>> getTodo() async {
    final db = await getDB();
    final todoList = await db.query('Todo');
    return todoList.map((e) => TodoModel.fromMap(e)).toList();
  }

  // delete item
  static Future<int> deltTode(int id) async {
    final db = await getDB();
    return db.delete('Todo', where: 'id = ?', whereArgs: [id]);
  }

  // edit todo
  static Future<int> updateTodo(TodoModel todo) async {
    final db = await getDB();
    return await db.update(
      'Todo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }
}
