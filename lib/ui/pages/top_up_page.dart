import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/providers/transaction_provider.dart';
import 'package:mov_id/core/providers/user_provider.dart';
import 'package:mov_id/ui/widgets/selectable_box.dart';
import 'package:provider/provider.dart';

class TopUpPage extends StatefulWidget {
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  var _isLoading = false;
  var _money = [
    50000,
    100000,
    150000,
    200000,
    250000,
    500000,
    750000,
    1000000,
  ];

  var _selectedMoney = 0;
  var _moneyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Top Up',
          style: ConstantVariable.textFont.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Insert Amount of Money',
              style: ConstantVariable.textFont.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _moneyController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              maxLines: 1,
              cursorColor: Colors.purple,
              onChanged: (value) {
                setState(() {
                  _selectedMoney = int.tryParse(value);
                });
              },
              decoration: InputDecoration(
                prefix: Text(
                  'IDR ',
                  style: ConstantVariable.textFont.copyWith(
                    color: Colors.black,
                  ),
                ),
                labelText: 'IDR ',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: '10000',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Choose ',
              style: ConstantVariable.textFont.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ..._money
                    .map(
                      (money) => SelectableBox(
                        title: NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'IDR ',
                          decimalDigits: 0,
                        ).format(money),
                        height: 50,
                        width: (ConstantVariable.deviceWidth(context) - 70) / 3,
                        isEnable: true,
                        isSelected: _selectedMoney == money,
                        onTap: () {
                          setState(() {
                            if (_selectedMoney != money) {
                              _selectedMoney = money;
                              _moneyController.text = _selectedMoney.toString();
                              _moneyController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                  offset: _moneyController.text.length,
                                ),
                              );
                            } else {
                              _selectedMoney = 0;
                              _moneyController.text = '0';
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _isLoading
          ? Container(
              height: 50,
              child: SpinKitThreeBounce(
                size: 15,
                color: ConstantVariable.accentColor2,
              ),
            )
          : Consumer2<UserProvider, TransactionProvider>(
              builder: (context, userProvider, transactionProvider, child) =>
                  Container(
                height: 50,
                width: ConstantVariable.deviceWidth(context),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: RaisedButton(
                  elevation: 0,
                  color: ConstantVariable.accentColor2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    _topUp(userProvider, transactionProvider);
                  },
                  child: Text(
                    'Top Up',
                    style: ConstantVariable.textFont.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void _topUp(
    UserProvider userProvider,
    TransactionProvider transactionProvider,
  ) async {
    var newBalance = userProvider.userApp.balance + _selectedMoney;

    setState(() {
      _isLoading = true;
    });
    // set new balance for user
    userProvider.updateUser(balance: newBalance);
    // await for storing transaction to firebase
    await transactionProvider.addTransaction(
      userId: userProvider.userApp.id,
      balance: _selectedMoney,
    );

    transactionProvider.getTransaction(userProvider.userApp.id);

    setState(() {
      _isLoading = false;
    });

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/top_up_success_page',
      ModalRoute.withName('/main_page'),
    );
  }
}
