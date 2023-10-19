// ignore_for_file: use_build_context_synchronously

import 'package:deepdive/core/Assets.dart';
import 'package:deepdive/core/Colors.dart';
import 'package:deepdive/drawer/widgets/ButtonDrawerItem.dart';
import 'package:deepdive/drawer/widgets/ImageProfile.dart';
import 'package:deepdive/home/HomePage.dart';
import 'package:deepdive/login/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../login/provider/AuthUserProvider.dart';

class DrawerBody extends StatefulWidget {
  const DrawerBody({Key? key}) : super(key: key);

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        final authUserController =
            ref.read(AuthUserStateController.provider.notifier);
        return Container(
          padding: EdgeInsets.only(top: size.height * 0.05),
          decoration: const BoxDecoration(
            color: colorBackground,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          width: size.width * 0.8,
          child: Column(
            children: [
              ImageProfile(
                adressEmail: authUserController.user!.result!.email!,
                imgProfile: imgUser,
                nameUser: authUserController.user!.result!.name!,
              ),
              const SizedBox(height: 10),
              ButtonItem(
                icon: CupertinoIcons.house_fill,
                label: 'Início',
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.route);
                },
              ),
              ButtonItem(
                icon: CupertinoIcons.square_arrow_left,
                label: 'Sair',
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.route);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
