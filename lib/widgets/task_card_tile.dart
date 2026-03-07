import 'package:flutter/material.dart';


class TaskCardTile extends StatelessWidget {
  const TaskCardTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.status,
    required this.date,
    required this.onTapEdit,
    required this.onTapDelete,
  });
  final String title, subTitle, status;
  final String date;
  final VoidCallback onTapEdit, onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
            Text(subTitle, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black54,), textAlign: TextAlign.justify,),
            const SizedBox(height: 4,),
            Text(date, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),),
            const SizedBox(height: 6),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadiusGeometry.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(status, style: TextStyle(color: Colors.white)),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onTapEdit,
                  child: Icon(Icons.edit_note_outlined, color: Colors.green),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onTapDelete,
                  child: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}