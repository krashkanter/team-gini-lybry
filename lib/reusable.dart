import 'package:flutter/material.dart';

toColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "ff" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

Color bgC = toColor("F5F5F3");
Color textC = toColor("333A3F");

Image logoWidget(String imageName, double x, double y) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: x,
    height: y,
  );
}
