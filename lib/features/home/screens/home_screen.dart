import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_goals/features/task_details/screens/task_details_screen.dart';
import 'package:my_goals/models/task_model.dart';
import 'package:my_goals/providers/task_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          if (provider.tasks == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: provider.tasks!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailsScreen(
                        task: provider.tasks![index],
                      ),
                    ),
                  );
                },
                title: Text(provider.tasks![index].title),
                subtitle: Text(provider.tasks![index].id!),
              );
            },
          );
        },
      ),
    );
  }
}
