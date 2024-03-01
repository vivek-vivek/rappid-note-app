import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../controller/providers/notes_provider.dart';
import '../model/notes_model.dart';

class AddNotesScreen extends StatefulWidget {
  final Task? task;

  AddNotesScreen({this.task});

  @override
  AddNotesScreenState createState() => AddNotesScreenState();
}

class AddNotesScreenState extends State<AddNotesScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.task?.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Note' : 'Update Note'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              Expanded(
                child: TextField(
                  scribbleEnabled: true,
                  maxLines: null,
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      labelText: 'Description', border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String title = _titleController.text.trim();
                  String description = _descriptionController.text.trim();
                  if (title.isNotEmpty && description.isNotEmpty) {
                    NotesProvider viewModel =
                        Provider.of<NotesProvider>(context, listen: false);
                    if (widget.task == null) {
                      viewModel.addNote(
                          Task(title: title, description: description));
                    } else {
                      // Update existing task
                      viewModel.updateTask(
                          Task(title: title, description: description),
                          widget.task?.id ?? "");
                    }
                    Navigator.pop(context);
                  } else {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please fill in all fields.'),
                    ));
                  }
                },
                child: Text(widget.task == null ? 'Add Task' : 'Update Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
