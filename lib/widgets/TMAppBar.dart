import 'package:flutter/material.dart';
class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/happy-confidence-portrait-male-person-fashion-stylish-isolated-studio-background-smile-handsome-trendy-outfit-312596543.jpg'),
              radius: 16,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Md Rahib',
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'rahib@gamil.com',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}