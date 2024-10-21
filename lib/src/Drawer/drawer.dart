import 'package:dealsify_production/api/get/get_profile.dart';
import 'package:dealsify_production/core/services/local_storage.dart';
import 'package:dealsify_production/src/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors_and_icons/images.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.get();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const UserAccountsDrawerHeader(

            accountName: Text(
              "Dealsify",
              // profileController.userData.value.name?.toString() ?? "",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontFamily: FontFamily.boldMulish,
              ),
            ),
            accountEmail: Text(
              "connect@dealsify.in",
              // profileController.userData.value.email?.toString() ?? "",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.regularMulish,
              ),
            ), 
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(ConstImg.appLogoFull),
            ),
            decoration: BoxDecoration(
            ),
          ),
          // ListTile(
          //   leading: const Icon(Icons.settings, color: Colors.black45),
          //   title: const Text(
          //     'Settings',
          //     style: TextStyle(
          //       fontFamily: FontFamily.regularMulish,
          //     ),
          //   ),
          //   onTap: () {},
          // ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.info, color: Colors.black54),
          //   title: const Text(
          //     'About',
          //     style: TextStyle(
          //       fontFamily: FontFamily.regularMulish,
          //     ),
          //   ),
          //   onTap: () {},
          // ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Logout',
                  middleText: 'Are you sure you want to logout?',
                  textCancel: 'Cancel',
                  textConfirm: 'Logout',
                  confirmTextColor: Colors.white,
                  onConfirm: () async {
                    final LocalDataModel? userInfo = await pref.get();
                    userInfo!.access_token = "";
                    userInfo.user_id = "";
                    userInfo.company_id = "";
                    pref.set(userInfo);
                    Get.off(const LoginScreen());
                  },
                );
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.regularMulish,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[300],
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
