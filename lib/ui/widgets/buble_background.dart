import 'package:flutter/material.dart';
import 'package:mov_id/core/base/constant_variable.dart';

Widget bubleBackground(BuildContext context) {
  return Positioned(
    right: -100,
    top: -100,
    child: Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ConstantVariable.primaryColor,
      ),
    ),
  );
}
