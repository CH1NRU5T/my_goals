import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_goals/features/task_details/widgets/progress_indicator.dart';
import 'package:my_goals/models/contribution_model.dart';
import 'package:my_goals/models/task_model.dart';
import 'package:my_goals/providers/contribution_provider.dart';
import 'package:provider/provider.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key, required this.task});
  final Task task;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  void initState() {
    super.initState();
    fetchContributions();
  }

  void fetchContributions() async {
    List<Contribution> contributions = [];
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('contributions')
        .where('task', isEqualTo: widget.task.id)
        .get();
    for (QueryDocumentSnapshot snap in qs.docs) {
      Contribution contribution =
          Contribution.fromMap(snap.data() as Map<String, dynamic>);
      contributions.add(contribution);
    }
    if (context.mounted) {
      context.read<ContributionProvider>().contributions = contributions;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCircularProgressIndicator(
                    current: widget.task.currentAmount,
                    max: widget.task.finalAmount,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.task.title,
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
                      'By ${DateFormat('MMM yyyy').format(widget.task.deadline)}',
                      style: const TextStyle(color: Color(0xff8385bd)),
                    ),
                    trailing: Text(
                      '\$${widget.task.finalAmount}',
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
                      color: Colors.blue,
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
                          '\$${(widget.task.finalAmount - widget.task.currentAmount).toString()}',
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
              ),
            ),
          ),
          Consumer<ContributionProvider>(
            builder: (context, provider, child) {
              if (provider.contributions == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contributions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: provider.contributions!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          trailing: Text(
                            DateFormat('dd MMM yyyy').format(
                                provider.contributions![index].contributedAt),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
                            '\$${provider.contributions![index].amount.toString()}',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
