import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../theme/colors.dart';

DeviceType getDeviceType(MediaQueryData mediaQueryData) {
  Orientation orientation = mediaQueryData.orientation;
  double width = 0;
  if (orientation == Orientation.landscape) {
    width = mediaQueryData.size.height;
  } else {
    width = mediaQueryData.size.width;
  }
  if (width >= 600) {
    return DeviceType.tablet;
  } else {
    return DeviceType.mobile;
  }
}

enum DeviceType { mobile, tablet }

const String icons = "icons/";

getSvgIcon(icon) {
  return SvgPicture.asset(icons + icon);
}

Future<void> flutterToast(String message, String type) async {
  Color backgroundColor = Colors.green;

  if (type == 'error') {
    backgroundColor = Colors.red;
  }

  await Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Future flutterToastt(
    dynamic message, String type, double height, String gravity) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity == "pin" ? ToastGravity.CENTER : ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: type == "error" ? Colors.red : green,
      textColor: Colors.white,
      fontSize: height * 0.02);
}

class EndPoint {
  static String imageShopUrl = "http://192.168.1.105:8000/image_shop/";
  static String url = "http://192.168.1.105:8000/api/";
  static String imageUrl = "http://192.168.1.105:8000/";
}

class ColorConstants {
  static Color gray50 = hexToColor('#e9e9e9');
  static Color gray100 = hexToColor('#bdbebe');
  static Color gray200 = hexToColor('#929293');
  static Color gray300 = hexToColor('#666667');
  static Color gray400 = hexToColor('#505151');
  static Color gray500 = hexToColor('#242526');
  static Color gray600 = hexToColor('#202122');
  static Color gray700 = hexToColor('#191a1b');
  static Color gray800 = hexToColor('#121313');
  static Color gray900 = hexToColor('#0e0f0f');
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

  return Color(int.parse(hex.substring(1), radix: 16) +
      (hex.length == 7 ? 0xFF000000 : 0x00000000));
}
