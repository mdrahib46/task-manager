import 'package:flutter/material.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({
    super.key, required this.taskCount, required this.cardTitle,
  });
  final String taskCount, cardTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(taskCount, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Text(cardTitle, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54),),
          ],
        ),
      ),
    );
  }
}