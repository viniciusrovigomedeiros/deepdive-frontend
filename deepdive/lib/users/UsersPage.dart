import 'package:deepdive/core/Assets.dart';
import 'package:deepdive/core/Colors.dart';
import 'package:flutter/material.dart';

import '../drawer/Drawer.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  static const route = '/users';

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: colorBackground,
        drawer: const Drawer(
          backgroundColor: Colors.transparent,
          child: DrawerPage(),
        ),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          title: SizedBox(height: 200, child: Image.asset(imgLogo)),
          actions: const [SizedBox()],
        ),
      ),
    );
  }
}
