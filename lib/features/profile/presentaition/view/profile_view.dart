import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_ease/core/services/cache_helper.dart';
import 'package:market_ease/features/profile/presentaition/view/widgets/profile_menu_item.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../generated/assets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userImagePath;

  @override
  void initState() {
    super.initState();
    userImagePath = CacheHelper().getDataString(key: 'user_image');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Profile",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Card
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: userImagePath == null
                            ? SvgPicture.asset(Assets.imagesProfileAvatar)
                            : Image.file(
                                File(userImagePath!),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          showImageSourceDialog(context, (XFile file) {
                            _saveImage(file);
                            setState(() {
                              userImagePath = file.path;
                            });
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                // Name & email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      CacheHelper().getData(key: AppConstants.userName) ??
                          "User Name",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CacheHelper().getData(key: AppConstants.userEmail) ??
                          "email@example.com",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.45),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Menu Items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ProfileMenuItem(
                    onTap: () {
                      context.push(AppRoutes.kAboutView);
                    },
                    icon: Icons.info_outline,
                    label: 'About',
                  ),
                  const SizedBox(height: 16),

                  ProfileMenuItem(
                    onTap: () {
                      context.go(AppRoutes.kLoginVIew);
                    },
                    isLogout: true,
                    icon: Icons.logout,
                    label: 'Logout',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _saveImage(XFile file) async {
  final appDir = await getApplicationDocumentsDirectory();
  final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
  CacheHelper().saveData(key: 'user_image', value: newFile.path);
}

void showImageSourceDialog(BuildContext context, Function(XFile) selectedFile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          'Choose Image Source',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                selectedFile(image);
              }
            },
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.camera_alt, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Camera',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                selectedFile(image);
              }
            },
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.photo_library, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Gallery',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
