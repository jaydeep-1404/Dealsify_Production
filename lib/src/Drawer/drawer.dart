import 'package:dealsify_production/api/get/get_profile.dart';
import 'package:dealsify_production/core/services/local_storage.dart';
import 'package:dealsify_production/src/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                profileController.userData.value.name?.toString() ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              accountEmail: Text(
                profileController.userData.value.email?.toString() ?? "",
                style: const TextStyle(color: Colors.black87),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/dealsify new Logo-02.png'),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white,Colors.blue.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // ListTile(
            //   leading: Icon(Icons.settings, color: Colors.blue.shade100),
            //   title: const Text('Settings'),
            //   onTap: () {},
            // ),
            // const Divider(),
            // ListTile(
            //   leading: Icon(Icons.info, color: Colors.blue.shade100),
            //   title: const Text('About'),
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
                label: const Text('Logout',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[300],
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        );
      },),
    );
  }
}
