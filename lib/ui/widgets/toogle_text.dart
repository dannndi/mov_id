import 'package:flutter/material.dart';
import 'package:mov_id/core/base/constant_variable.dart';

class ToogleText extends StatelessWidget {
  String text;
  Color color;
  bool isSelected;
  double width;
  double space;
  Function onTap;

  ToogleText({
    @required this.text,
    @required this.isSelected,
    @required this.onTap,
    this.space,
    this.color,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 60,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: ConstantVariable.textFont.copyWith(
                color: isSelected
                    ? color ?? ConstantVariable.accentColor1
                    : ConstantVariable.accentColor3.withOpacity(0.7),
                fontSize: isSelected ? 17 : 15,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            SizedBox(height: space ?? 2),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: isSelected ? 4 : 0,
              width: isSelected ? width ?? 80 : 0,
              decoration: BoxDecoration(
                color: isSelected
                    ? color ?? ConstantVariable.accentColor1
                    : ConstantVariable.accentColor3.withOpacity(0.7),
                borderRadius: BorderRadius.circular(2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
