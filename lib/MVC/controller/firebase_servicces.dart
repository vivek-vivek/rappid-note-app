// lib/service/firebase_service.dart

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/notes_model.dart';

class FirebaseService {
  final CollectionReference noteCollection =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(Task task) async {
    // Add the task to Firestore with recipient's email
    task.id = noteCollection.doc().id;
    await noteCollection.add(task.toJson());
  }

  Stream<List<Task>> getNote() {
    return noteCollection
        // .where('recipientEmail', isEqualTo: userEmail)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Task.fromJson({
                'id': doc.id,
                'title': doc['title'],
                'description': doc['description'],
              }))
          .toList();
    });
  }

  Future<void> updateTask(Task task, String taskId) async {
    try {
      // Update the task in Firestore
      await noteCollection
          .doc(taskId)
          .update(task.toJson())
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
      log("completed  $taskId");
    } catch (error) {
      print('Error updating task: $error');
      throw error; // Rethrow the error to propagate it further if needed
    }
  }
}
