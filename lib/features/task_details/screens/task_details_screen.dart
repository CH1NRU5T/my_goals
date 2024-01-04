import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_goals/features/task_details/services/task_details_service.dart';
import 'package:my_goals/features/task_details/widgets/progress_indicator.dart';
import 'package:my_goals/models/task_model.dart';
import 'package:my_goals/providers/contribution_provider.dart';
import 'package:my_goals/providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskDetailsScreen extends StatelessWidget {
  TaskDetailsScreen({super.key, required this.id});
  final String id;

  final TaskDetailsService _taskDetailsService = TaskDetailsService();

  @override
  Widget build(BuildContext context) {
    _taskDetailsService.fetchContributions(
      id: id,
      context: context,
    );
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.5,
            decoration: const BoxDecoration(
              color: Color(0xff2e2c75),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Consumer<TaskProvider>(
                  builder: (context, taskProvider, child) {
                Task task = taskProvider.tasks!
                    .firstWhere((element) => element.id == id);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCircularProgressIndicator(
                      current: task.currentAmount,
                      max: task.finalAmount,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      title: const Text(
                        'Goal',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'By ${DateFormat('MMM yyyy').format(task.deadline)}',
                        style: const TextStyle(color: Color(0xff8385bd)),
                      ),
                      trailing: Text(
                        '\$${task.finalAmount}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: task.currentAmount >= task.finalAmount
                            ? Colors.green
                            : Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Need more savings',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '\$${task.currentAmount >= task.finalAmount ? 0 : (task.finalAmount - task.currentAmount).toString()}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
          Expanded(
            child: Consumer<ContributionProvider>(
              builder: (context, provider, child) {
                if (provider.contributions == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Contributions',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: provider.contributions!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              trailing: IconButton(
                                onPressed: () async {
                                  _taskDetailsService.deleteContribution(
                                    contributionID:
                                        provider.contributions![index].id!,
                                    taskID: id,
                                    context: context,
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              titleTextStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                provider.contributions![index].name,
                              ),
                              subtitle: Text(
                                '\$${provider.contributions![index].amount.toString()}\n${DateFormat('dd MMM yyyy').format(provider.contributions![index].contributedAt)}',
                              ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Task task = context
                              .read<TaskProvider>()
                              .tasks!
                              .firstWhere((element) => element.id == id);
                          if (task.currentAmount >= task.finalAmount) {
                            return;
                          }
                          await _taskDetailsService.makeRandomContribution(
                            id: id,
                            context: context,
                          );
                        },
                        child: const Text(
                          'Add Random Contribution',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
