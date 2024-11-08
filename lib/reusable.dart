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

Widget Book(BuildContext context, String link, String title) {
  return Container(
    height: 270,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(link), // Correct usage
                fit: BoxFit.cover,
              ),
              border: Border.all(color: toColor("333A3F"), width: 5),
              color: toColor("56C0A1"),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Align(
            alignment: Alignment(-0.9, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Text(
                title,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
