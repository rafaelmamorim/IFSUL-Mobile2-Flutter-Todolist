import '../models/task.dart';
import 'database_helper.dart';

class TaskDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> createTask(Task task) async {
    final db = await dbHelper.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getTasks() async {
    final db = await dbHelper.database;
    final result = await db.query('tasks', orderBy: 'isDone');
    return result.map((json) => Task.fromMap(json)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await dbHelper.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await dbHelper.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
