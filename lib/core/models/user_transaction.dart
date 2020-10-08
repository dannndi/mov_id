import 'package:equatable/equatable.dart';

class UserTransaction extends Equatable {
  final String userId;
  final String title;
  final String subTitle;
  final int amount;
  final DateTime dateTime;

  UserTransaction({
    this.userId,
    this.title,
    this.subTitle,
    this.amount,
    this.dateTime,
  });

  @override
  List<Object> get props => [
        userId,
        title,
        subTitle,
        amount,
        dateTime,
      ];
}
