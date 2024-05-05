import 'package:ask_pdf/services/constants.dart';
import 'package:flutter/material.dart';

class AppUserAvatarWidget extends StatelessWidget {
  const AppUserAvatarWidget({
    required this.userAvatar,
    super.key,
    this.size = 40,
  });

  final String userAvatar;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: Colors.grey,
      foregroundImage: userAvatar.isEmpty ? NetworkImage(userAvatar) : null,
      child: userAvatar.isNotEmpty ? Image.asset(AppImages.userImage) : null,
    );
  }
}
