import 'package:flutter/material.dart';

Widget generateStar(double rating) {
  List<Widget> list = List();

  for (var i = 0; i < 5; i++) {
    if (i < (rating / 2).round()) {
      list.add(Icon(
        Icons.star,
        color: Colors.amber,
        size: 15,
      ));
    } else {
      list.add(Icon(
        Icons.star_border,
        color: Colors.amber,
        size: 15,
      ));
    }
  }

  return Row(
    children: [
      ...list,
      SizedBox(
        width: 10,
      ),
      Text(
        rating.toString(),
      ),
    ],
  );
}
