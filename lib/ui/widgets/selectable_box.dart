import 'package:flutter/material.dart';
import 'package:mov_id/core/base/constant_variable.dart';

class SelectableBox extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final bool isEnable;
  final bool isSelected;
  final Function onTap;

  SelectableBox({
    this.height,
    this.width,
    @required this.title,
    this.isEnable = true,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          //perform onTap
          onTap();
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: isEnable
              ? isSelected ? ConstantVariable.primaryColor : Colors.transparent
              : ConstantVariable.accentColor3,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isEnable
                ? isSelected
                    ? ConstantVariable.primaryColor
                    : ConstantVariable.accentColor3
                : ConstantVariable.accentColor3,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: ConstantVariable.textFont.copyWith(
              color: isEnable
                  ? isSelected ? Colors.white : Colors.black
                  : ConstantVariable.accentColor3,
            ),
          ),
        ),
      ),
    );
  }
}
