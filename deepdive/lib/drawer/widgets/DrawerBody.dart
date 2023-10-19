// ignore_for_file: use_build_context_synchronously

import 'package:deepdive/core/Assets.dart';
import 'package:deepdive/core/Colors.dart';
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
              _ImageProfile(
                adressEmail: authUserController.user!.result!.email!,
                imgProfile: imgUser,
                nameUser: authUserController.user!.result!.name!,
              ),
              const SizedBox(height: 10),
              _ButtonItem(
                icon: CupertinoIcons.house_fill,
                label: 'Início',
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.route);
                },
              ),
              _ButtonItem(
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

class _ButtonItem extends StatelessWidget {
  final String label;
  final Function onPressed;
  final IconData icon;

  const _ButtonItem({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      minWidth: size.width * 0.6,
      height: size.height * 0.05,
      onPressed: () => onPressed(),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 30),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageProfile extends StatelessWidget {
  final String nameUser;
  final String adressEmail;
  final String imgProfile;

  const _ImageProfile({
    Key? key,
    required this.nameUser,
    required this.adressEmail,
    required this.imgProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            padding: EdgeInsets.zero,
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: FadeInImage.assetNetwork(
                placeholder: imgFavicon,
                image: imgProfile,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 500),
                fadeInCurve: Curves.easeIn,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            nameUser,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            adressEmail,
            style: const TextStyle(
              color: Color.fromARGB(255, 163, 163, 163),
              fontSize: 15,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 0.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
