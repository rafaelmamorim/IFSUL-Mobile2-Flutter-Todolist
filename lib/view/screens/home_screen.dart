import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/view/screens/task_form_screen.dart';
import '../../viewmodel/task_viewmodel.dart';
import '../../data/models/task.dart';
import '../widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = Provider.of<TaskViewModel>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("ToDo List")),
      body: FutureBuilder(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.tasks.isEmpty) {
            return const Center(child: Text("Nenhuma tarefa encontrada."));
          }
          return ListView.builder(
            itemCount: viewModel.tasks.length,
            itemBuilder: (context, index) {
              final Task task = viewModel.tasks[index];
              return TaskItem(
                task: task,
                onToggle: (isDone) {
                  final updatedTask = Task(
                    id: task.id,
                    title: task.title,
                    description: task.description,
                    isDone: isDone,
                  );
                  viewModel.updateTask(updatedTask);
                },
                onDelete: () {
                  if (task.id != null) {
                    viewModel.deleteTask(task.id!);
                  }
                },
                onTap: () {
                  // Navegue para a tela de edição ou detalhes da tarefa
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        color: Colors.grey[200],
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Rafael Amorim <rafaelamorim@ifsul.edu.br>",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
              "Objetivo: Compreender o MVVM",
              textAlign: TextAlign.center, // Centralizando o texto
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
