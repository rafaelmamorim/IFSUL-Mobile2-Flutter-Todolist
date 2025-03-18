import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/task.dart';
import '../../viewmodel/task_viewmodel.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task; // Se for nulo, indica criação; caso contrário, edição

  const TaskFormScreen({super.key, this.task});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // Se for edição, pré-preenche os campos com os dados existentes.
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.task?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final viewModel = Provider.of<TaskViewModel>(context, listen: false);
      final title = _titleController.text;
      final description = _descriptionController.text;

      if (widget.task == null) {
        // Criação de nova tarefa
        final newTask = Task(title: title, description: description);
        viewModel.addTask(newTask);
      } else {
        // Atualização da tarefa existente
        final updatedTask = Task(
          id: widget.task!.id,
          title: title,
          description: description,
          isDone: widget.task!.isDone,
        );
        viewModel.updateTask(updatedTask);
      }
      Navigator.pop(context); // Retorna para a tela anterior após salvar
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar Tarefa' : 'Nova Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o título da tarefa.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição da tarefa.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  isEditing ? 'Salvar Alterações' : 'Adicionar Tarefa',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
