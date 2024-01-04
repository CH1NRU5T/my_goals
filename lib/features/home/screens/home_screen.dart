import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_goals/features/home/services/home_service.dart';
import 'package:my_goals/features/task_details/screens/task_details_screen.dart';
import 'package:my_goals/providers/task_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeService _homeService = HomeService();

  void init(BuildContext context) {
    _homeService
        .makeMockTask(context: context)
        .then((value) => _homeService.fetchTasks(context: context));
  }

  @override
  Widget build(BuildContext context) {
    init(context);
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
                        id: provider.tasks![index].id!,
                      ),
                    ),
                  );
                },
                title: Text(provider.tasks![index].title),
                subtitle: Text(
                    '\$${provider.tasks![index].currentAmount.toString()}'),
              );
            },
          );
        },
      ),
    );
  }
}
