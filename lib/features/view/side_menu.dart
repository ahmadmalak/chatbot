import 'package:ask_pdf/services/constants.dart';
import 'package:ask_pdf/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
    required this.onProfileTap,
    required this.onHistoryTap,
    required this.onListOfOffersTap,
  });
  final VoidCallback onProfileTap;
  final VoidCallback onHistoryTap;
  final VoidCallback onListOfOffersTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          AppImages.logoImage,
          height: 70,
        ),
        const SizedBox(
          height: 80,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onProfileTap,
            child: Row(
              children: [
                Image.asset(
                  AppImages.userImage,
                  height: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                const TextWidget(
                  label: "Profile",
                  fontSize: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onHistoryTap,
            child: Row(
              children: [
                SvgPicture.asset(
                  AppSvgs.history,
                  height: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                const TextWidget(
                  label: "History",
                  fontSize: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onListOfOffersTap,
            child: Row(
              children: [
                SvgPicture.asset(
                  AppSvgs.list,
                  height: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                const TextWidget(
                  label: "List",
                  fontSize: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                AppSvgs.logout,
                height: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              const TextWidget(
                label: "Logout",
                fontSize: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
