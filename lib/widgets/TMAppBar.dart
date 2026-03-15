import 'package:flutter/material.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/screens/signin_screen.dart';
import 'package:task_manager_app/screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  TMAppBar({super.key});

  final String? _uerName =
      '${AuthController.userModel!.firstName} ${AuthController.userModel!.lastName}';
  final String? _email = '${AuthController.userModel!.email}';
  final String? _profilePhoto = "${AuthController.userModel!.photo}";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, UpdateProfileScreen.name);
      },
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                _profilePhoto!,
              ),
              radius: 16,

            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _uerName!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                   _email!,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthController.clearData();
              await Navigator.pushNamedAndRemoveUntil(
                context,
                SignInScreen.name,
                (route) => false,
              );
            },
            icon: Icon(Icons.login_sharp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
