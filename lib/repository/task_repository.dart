import '../data/local/task_dao.dart';
import '../data/models/task.dart';

//Responsável por abstrair as operações do DAO.
class TaskRepository {
  final TaskDao taskDao;

  TaskRepository({required this.taskDao});

  Future<int> addTask(Task task) => taskDao.createTask(task);
  Future<List<Task>> fetchTasks() => taskDao.getTasks();
  Future<int> updateTask(Task task) => taskDao.updateTask(task);
  Future<int> deleteTask(int id) => taskDao.deleteTask(id);
}
