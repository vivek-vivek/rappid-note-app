// lib/viewmodel/NoteListViewProvider_list_viewmodel.dart

import 'package:flutter/material.dart';
import 'dart:developer';
import '../../model/notes_model.dart';
import '../firebase_servicces.dart';

class NotesProvider extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

  void addNote(Task task) async {
    await _firebaseService.addNote(task);
  }

  Stream<List<Task>> getNote() {
    return _firebaseService.getNote();
  }

  void updateTask(Task task, String taskId) async {
    await _firebaseService.updateTask(task, taskId);
  }
}
