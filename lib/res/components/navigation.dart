import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';

class ReusableNavigation extends StatefulWidget {
  const ReusableNavigation({super.key});

  @override
  State<ReusableNavigation> createState() => _ReusableNavigationState();
}

class _ReusableNavigationState extends State<ReusableNavigation> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Welcome to',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Text(
                  'Greater Hyderabad Municipal',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Text(
                  'Corporation',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
          ),
          createDrawerItem(maintext: 'Profile'),
          ListTile(
            leading: const Icon(
              Icons.notifications,
            ),
            title: const Text(
              'Inbox',
              style: TextStyle(fontSize: 16.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.inboxnotification);
            },
          ),
          const Divider(color: Colors.black),
          createDrawerItem(maintext: 'Services'),
          ListTile(
            leading: const Icon(
              Icons.inbox,
            ),
            title: const Text(
              'Grievances',
              style: TextStyle(fontSize: 16.0),
            ),
            onTap: () {
              EasyLoading.show();
              Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.report,
            ),
            title: const Text(
              'Abstract Report',
              style: TextStyle(fontSize: 16.0),
            ),
            onTap: () {
              EasyLoading.show();
              Navigator.pushNamed(context, AppRoutes.abstractreport);
            },
          ),
          const Divider(color: Colors.black),
          createDrawerItem(maintext: 'Advertisement'),
          ListTile(
            leading: const Icon(
              Icons.window,
            ),
            title: const Text(
              'Hoardings Info',
              style: TextStyle(fontSize: 16.0),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(color: Colors.black),
          createDrawerItem(maintext: 'Others'),
          ListTile(
            leading: const Icon(
              Icons.color_lens,
            ),
            title: const Text(
              'Themes',
              style: TextStyle(fontSize: 16.0),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app_outlined,
            ),
            title: const Text(
              'Exit',
              style: TextStyle(fontSize: 16.0),
            ),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Exit application?",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Are you sure you want to Exit from this application?",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'NO',
                              style: TextStyle(color: Colors.teal),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (Platform.isAndroid) {
                                SystemNavigator.pop();
                              } else if (Platform.isIOS) {
                                exit(0);
                              }
                            },
                            child: const Text(
                              'YES',
                              style: TextStyle(color: Colors.teal),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 16.0),
            ),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Logout application?",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Are you sure you want to Logout from this application?",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'NO',
                              style: TextStyle(color: Colors.teal),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, AppRoutes.myloginpage),
                            child: const Text(
                              'YES',
                              style: TextStyle(color: Colors.teal),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: Center(
              child: Text(
                'Version 2.8',
                style: TextStyle(color: Colors.black38, fontSize: 16.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget createDrawerItem({required String maintext}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          child: Text(
            maintext,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
