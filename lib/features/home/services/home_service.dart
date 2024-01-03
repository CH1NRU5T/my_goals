import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_goals/models/contribution_model.dart';
import 'package:my_goals/models/task_model.dart';
import 'package:my_goals/providers/task_provider.dart';
import 'package:provider/provider.dart';

class HomeService {
  //* This function makes a mock task and contribution so as to display it on the app, as the app does not have the ability to create tasks and contributions yet.
  Future<void> makeMockTask({required BuildContext context}) async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('tasks')
          .where('createdBy', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (snap.docs.isNotEmpty) {
        return;
      }
      DocumentReference docref =
          await FirebaseFirestore.instance.collection('tasks').add(Task(
                title: 'Mock Task',
                createdAt: DateTime.now(),
                createdBy: FirebaseAuth.instance.currentUser!.uid,
                finalAmount: 50000,
                currentAmount: 12000,
                deadline: DateTime.now().add(const Duration(days: 30)),
              ).toMap());
      await FirebaseFirestore.instance.collection('contributions').add(
            Contribution(
              task: docref.id,
              name: 'Mock Contribution',
              amount: 12000,
              contributedAt: DateTime.now(),
            ).toMap(),
          );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  void fetchTasks({required BuildContext context}) async {
    try {
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection('tasks')
          .where('createdBy', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      List<Task> tasks = [];
      for (QueryDocumentSnapshot snap in qs.docs) {
        Task task = Task.fromMap(snap.data() as Map<String, dynamic>);
        task.id = snap.id;
        tasks.add(task);
      }
      if (context.mounted) {
        context.read<TaskProvider>().tasks = tasks;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }
}
