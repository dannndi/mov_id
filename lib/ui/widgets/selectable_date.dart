import 'package:flutter/material.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import '../../core/extensions/datetime_extension.dart';

class SelectableDate extends StatelessWidget {
  DateTime date;
  bool isSelected;
  Function onTap;

  SelectableDate({
    @required this.date,
    @required this.isSelected,
    @required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isSelected ? 80 : 80,
        width: isSelected ? 90 : 60,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isSelected ? date.fullDayName : date.shortDayName,
              style: ConstantVariable.textFont.copyWith(
                color: isSelected ? Colors.black : Colors.grey,
                fontSize: 17,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isSelected ? 15 : 10),
            Text(
              date.day.toString(),
              style: ConstantVariable.textFont.copyWith(
                color: isSelected ? Colors.black : Colors.grey,
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            SizedBox(height: isSelected ? 15 : 0),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: isSelected ? 5 : 0,
                width: isSelected ? 25 : 0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: isSelected
                      ? ConstantVariable.accentColor4
                      : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
