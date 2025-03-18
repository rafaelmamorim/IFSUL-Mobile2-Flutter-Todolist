import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/local/task_dao.dart';
import 'repository/task_repository.dart';
import 'viewmodel/task_viewmodel.dart';
import 'view/screens/home_screen.dart';

void main() {
  // Instancie o DAO e o repositório
  final taskDao = TaskDao();
  final repository = TaskRepository(taskDao: taskDao);

  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskViewModel(repository: repository),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'ToDo List',
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}
