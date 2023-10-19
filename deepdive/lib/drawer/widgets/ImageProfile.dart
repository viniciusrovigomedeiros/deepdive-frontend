import 'package:flutter/material.dart';
import '../../core/Assets.dart';

class ImageProfile extends StatelessWidget {
  final String nameUser;
  final String adressEmail;
  final String imgProfile;

  const ImageProfile({
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
