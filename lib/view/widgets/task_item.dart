import 'package:flutter/material.dart';
import 'package:todolist/view/screens/task_form_screen.dart';
import '../../data/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onToggle;
  final VoidCallback? onDelete;

  const TaskItem({
    super.key,
    required this.task,
    this.onTap,
    this.onToggle,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (onDelete != null) {
          onDelete!();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Tarefa excluída')));
        }
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 8),
            Text("Excluir", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskFormScreen(task: task)),
          );
        },
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(task.description),
        trailing: Checkbox(
          value: task.isDone,
          onChanged: (value) {
            if (value != null && onToggle != null) {
              onToggle!(value);
            }
          },
        ),
      ),
    );
  }
}
