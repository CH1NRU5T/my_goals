import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_goals/models/contribution_model.dart';
import 'package:my_goals/providers/contribution_provider.dart';
import 'package:my_goals/providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskDetailsService {
  Future<void> deleteContribution({
    required String contributionID,
    required String taskID,
    required BuildContext context,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('contributions')
          .doc(contributionID)
          .delete();
      if (context.mounted) {
        double amount =
            context.read<ContributionProvider>().delete(contributionID);
        await FirebaseFirestore.instance
            .collection('tasks')
            .doc(taskID)
            .update({
          'currentAmount': FieldValue.increment(-amount),
        });
        if (context.mounted) {
          context.read<TaskProvider>().modify(taskID, -amount);
        }
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

  Future<void> makeRandomContribution({
    required String id,
    required BuildContext context,
  }) async {
    try {
      Contribution contribution = Contribution(
        name: 'Random',
        amount: Random().nextInt(1000).toDouble(),
        contributedAt: DateTime.now(),
        task: id,
      );
      await FirebaseFirestore.instance
          .collection('contributions')
          .add(contribution.toMap())
          .then((value) {
        contribution.id = value.id;
      });
      if (context.mounted) {
        context.read<ContributionProvider>().add(contribution);
      }
      await FirebaseFirestore.instance.collection('tasks').doc(id).update({
        'currentAmount': FieldValue.increment(contribution.amount),
      });
      if (context.mounted) {
        context.read<TaskProvider>().modify(id, contribution.amount);
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

  void fetchContributions({
    required String id,
    required BuildContext context,
  }) async {
    try {
      List<Contribution> contributions = [];
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection('contributions')
          .where('task', isEqualTo: id)
          .get();
      for (QueryDocumentSnapshot snap in qs.docs) {
        Contribution contribution =
            Contribution.fromMap(snap.data() as Map<String, dynamic>);
        contribution.id = snap.id;
        contributions.add(contribution);
      }
      if (context.mounted) {
        context.read<ContributionProvider>().contributions = contributions;
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
