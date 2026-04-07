import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/provider/atuh_provider.dart';
import 'package:task_manager_app/screens/signin_screen.dart';
import 'package:task_manager_app/screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  TMAppBar({super.key, this.isProfileOpen = false});

  final bool isProfileOpen;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final user = authProvider.userModel;



    final String _usrName = user != null ? '${user.firstName} ${user.lastName}' : 'Guest User';
    final String _email = user?.email ?? '';
    final String _profilePhoto = user?.photo ?? '';

    return GestureDetector(
      onTap: () {
        if(isProfileOpen){
          return;
        }
        Navigator.pushNamed(context, UpdateProfileScreen.name);
      },
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: (_profilePhoto.isNotEmpty)
                    ? Image.network(
                  _profilePhoto,
                  fit: BoxFit.cover,
                  width: 32,
                  height: 32,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/avatar.jpg');
                  },
                )
                    : Image.asset('assets/images/avatar.jpg'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _usrName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    _email,
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
