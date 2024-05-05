import 'dart:typed_data';

import 'package:ask_pdf/services/constants.dart';
import 'package:ask_pdf/widgets/text_widget.dart';
import 'package:ask_pdf/widgets/user_avatar_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({
    required this.imageUrl,
    required this.onImageSelected,
    super.key,
  });

  final String? imageUrl;
  final ValueChanged<String>? onImageSelected;

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  String selectedFile = '';
  Uint8List? image;

  void _selectFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedFile = result.files.first.name;
      });
      image = result.files.first.bytes;
      widget.onImageSelected!(selectedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectFile();
      },
      child: SizedBox(
        height: 160,
        width: 250,
        child: Stack(
          children: [
            Positioned(
              right: 20,
              top: 30,
              child: Container(
                height: 100,
                width: 220,
                decoration: BoxDecoration(
                  color: secondary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Row(
                        children: [
                          TextWidget(
                            label: "Profile",
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 5,
              child: SizedBox(
                height: 120,
                child: Stack(
                  children: [
                    if (image != null)
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.memory(
                            image!,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        child: AppUserAvatarWidget(
                          userAvatar: widget.imageUrl ?? '',
                          size: 30,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
