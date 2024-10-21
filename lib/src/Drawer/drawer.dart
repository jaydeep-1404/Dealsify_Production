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
              ),
            ),
            accountEmail: Text(
              "connect@dealsify.in",
              // profileController.userData.value.email?.toString() ?? "",
              style: TextStyle(color: Colors.black87),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(ConstImg.appLogoFull),
            ),
            // currentAccountPicture: Container(
            //   decoration: const BoxDecoration(
            //     color: Colors.black12,
            //     shape: BoxShape.circle,
            //   ),
            //   child: const Center(
            //     child: Text(
            //       "D",
            //       style: TextStyle(fontSize: 25),
            //     ),
            //   ),
            // ),
            decoration: BoxDecoration(
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
      ),
      // child: Obx(() {
      //   return Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       UserAccountsDrawerHeader(
      //         accountName: Text(
      //           "",
      //           // profileController.userData.value.name?.toString() ?? "",
      //           style: const TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.black87,
      //           ),
      //         ),
      //         accountEmail: Text(
      //           "connect@dealsify.in",
      //           // profileController.userData.value.email?.toString() ?? "",
      //           style: const TextStyle(color: Colors.black87),
      //         ),
      //         // currentAccountPicture: const CircleAvatar(
      //         //   backgroundImage: AssetImage('assets/dealsify-02.png'),
      //         // ),
      //         currentAccountPicture: Container(
      //           decoration: const BoxDecoration(
      //             color: Colors.black12,
      //             shape: BoxShape.circle,
      //           ),
      //           child: const Center(
      //             child: Text(
      //               "D",
      //               style: TextStyle(fontSize: 25),
      //             ),
      //           ),
      //         ),
      //         decoration: const BoxDecoration(
      //         ),
      //       ),
      //       // ListTile(
      //       //   leading: Icon(Icons.settings, color: Colors.blue.shade100),
      //       //   title: const Text('Settings'),
      //       //   onTap: () {},
      //       // ),
      //       // const Divider(),
      //       // ListTile(
      //       //   leading: Icon(Icons.info, color: Colors.blue.shade100),
      //       //   title: const Text('About'),
      //       //   onTap: () {},
      //       // ),
      //       const Spacer(),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ElevatedButton.icon(
      //           onPressed: () {
      //             Get.defaultDialog(
      //               title: 'Logout',
      //               middleText: 'Are you sure you want to logout?',
      //               textCancel: 'Cancel',
      //               textConfirm: 'Logout',
      //               confirmTextColor: Colors.white,
      //               onConfirm: () async {
      //                 final LocalDataModel? userInfo = await pref.get();
      //                 userInfo!.access_token = "";
      //                 userInfo.user_id = "";
      //                 userInfo.company_id = "";
      //                 pref.set(userInfo);
      //                 Get.off(const LoginScreen());
      //               },
      //             );
      //           },
      //           icon: const Icon(Icons.logout, color: Colors.white),
      //           label: const Text('Logout',style: TextStyle(color: Colors.white),),
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.red[300],
      //             padding: const EdgeInsets.symmetric(vertical: 12),
      //           ),
      //         ),
      //       ),
      //     ],
      //   );
      // },),
    );
  }
}
