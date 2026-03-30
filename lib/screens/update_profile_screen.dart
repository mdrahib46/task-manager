import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/widgets/TMAppBar.dart';
import 'package:task_manager_app/widgets/custom_app_background.dart';
import 'package:task_manager_app/widgets/snackbar_message.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String name = '/Profile-Screen';
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;
  bool inProgress = false;

  @override
  void initState() {
    _setUserData();
    super.initState();
  }

  void _setUserData() {
    _emailTEController.text = AuthController.userModel?.email ?? '';
    _firstNameTEController.text = AuthController.userModel?.firstName ?? '';
    _lastNameTEController.text = AuthController.userModel?.lastName ?? '';
    _mobileTEController.text = AuthController.userModel?.mobile ?? '';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(isProfileOpen: true),
      body: CustomAppBackground(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(
                  'Add New Task ',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildImagePickerContainer(),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailTEController,
                  enabled: false,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your email";
                    }
                    final emailRegexp = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!emailRegexp.hasMatch(value.trim())) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: InputDecoration(hintText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: InputDecoration(hintText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your last name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _mobileTEController,
                  decoration: InputDecoration(hintText: 'Mobile'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your mobile number";
                    }

                    final mobileRegexp = RegExp(r'^01[3-9]\d{8}$');

                    if (!mobileRegexp.hasMatch(value.trim())) {
                      return "Enter a valid mobile number";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length <= 7) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: (){},
                  child: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePickerContainer() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 50,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Text('Photos', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Center(
            child: Text(
              _getSelectedPhotoTitle(),
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  String _getSelectedPhotoTitle() {
    if (_selectedImage != null) {
      return _selectedImage!.name;
    }
    return 'Select photo';
  }

  Future<void> _pickImage() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedImage != null) {
        _selectedImage = pickedImage;
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        showSnackBarMessage(context: context, message: "Error picking image");
      }
    }
  }

  void _clearText() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
    super.dispose();
  }
}
