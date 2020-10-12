import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/providers/transaction_provider.dart';
import 'package:mov_id/core/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../core/extensions/datetime_extension.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  User user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Wallet',
          style: ConstantVariable.textFont.copyWith(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer2<UserProvider, TransactionProvider>(
          builder: (context, userProvider, transactionProvider, _) {
        //
        if (userProvider.userApp == null) {
          userProvider.getUser(userId: user.uid);
        }
        //
        if (transactionProvider.userTransaction == null) {
          transactionProvider.getTransaction(user.uid);
        }
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: ConstantVariable.deviceHeight(context) * 0.23,
                width: ConstantVariable.deviceWidth(context) - 40,
                decoration: BoxDecoration(
                  color: ConstantVariable.accentColor4,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: CardClipper(),
                      child: Container(
                        height: ConstantVariable.deviceHeight(context) * 0.23,
                        width: ConstantVariable.deviceWidth(context) - 40,
                        padding: EdgeInsets.only(right: 20, top: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white10,
                              Colors.white30,
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ConstantVariable.accentColor1,
                              ),
                            ),
                            SizedBox(width: 6),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ConstantVariable.accentColor2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: ConstantVariable.deviceHeight(context) * 0.23,
                      width: ConstantVariable.deviceWidth(context) - 40,
                      padding: EdgeInsets.only(left: 10, bottom: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          userProvider.userApp != null
                              ? Text(
                                  NumberFormat.currency(
                                          locale: 'id_ID',
                                          decimalDigits: 0,
                                          symbol: 'IDR ')
                                      .format(userProvider.userApp.balance),
                                  style: ConstantVariable.textFont.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Container(
                                  height: 40,
                                  width: 40,
                                  child: SpinKitThreeBounce(
                                    size: 20,
                                    color: ConstantVariable.accentColor3,
                                  ),
                                ),
                          SizedBox(height: 15),
                          Text(
                            'Name :',
                            style: ConstantVariable.textFont.copyWith(
                              color: Colors.white,
                              fontSize: 9,
                            ),
                          ),
                          userProvider.userApp != null
                              ? Text(
                                  userProvider.userApp.name,
                                  style: ConstantVariable.textFont.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Container(
                                  height: 20,
                                  width: 30,
                                  child: SpinKitThreeBounce(
                                    size: 10,
                                    color: ConstantVariable.accentColor3,
                                  ),
                                ),
                          SizedBox(height: 5),
                          Text(
                            'ID :',
                            style: ConstantVariable.textFont.copyWith(
                              color: Colors.white,
                              fontSize: 9,
                            ),
                          ),
                          userProvider.userApp != null
                              ? Text(
                                  userProvider.userApp.id
                                      .toUpperCase()
                                      .split('')
                                      .take(15)
                                      .join(),
                                  style: ConstantVariable.textFont.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Container(
                                  height: 20,
                                  width: 30,
                                  child: SpinKitThreeBounce(
                                    size: 10,
                                    color: ConstantVariable.accentColor3,
                                  ),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Recent Transaction',
                style: ConstantVariable.textFont.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  child: transactionProvider.userTransaction != null
                      ? ListView.builder(
                          itemCount: transactionProvider.userTransaction.length,
                          itemBuilder: (context, index) {
                            var userTransaction =
                                transactionProvider.userTransaction;
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userTransaction[index].title,
                                    style: ConstantVariable.textFont.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        userTransaction[index].subTitle,
                                        style:
                                            ConstantVariable.textFont.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'id_ID',
                                                decimalDigits: 0,
                                                symbol: 'IDR ')
                                            .format(
                                                userTransaction[index].amount),
                                        style:
                                            ConstantVariable.textFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      userTransaction[index].dateTime.fullDate,
                                      style: ConstantVariable.textFont.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Container(
                            height: 20,
                            width: 30,
                            child: SpinKitThreeBounce(
                              size: 10,
                              color: ConstantVariable.accentColor3,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class CardClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
