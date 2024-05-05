import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

Color scaffoldBackgroundColor = const Color(0xFF343541);
Color cardColor = const Color(0xFF444654);
Color secondary = const Color(0xFF515151);
Color primary = const Color(0xFF62F2FF);

class AppImages {
  static const String userImage = 'assets/images/person.png';
  static const String logoImage = 'assets/images/logo.png';
}

class AppSvgs {
  static const String history = 'assets/svgs/history-icon.svg';
  static const String list = 'assets/svgs/list-icon.svg';
  static const String logout = 'assets/svgs/logout-icon.svg';
  static const String flash = 'assets/svgs/flash.svg';
}

GetStorage box = GetStorage();
const uuid = Uuid();
