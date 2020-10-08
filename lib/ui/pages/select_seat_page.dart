import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/models/ticket.dart';
import 'package:mov_id/ui/widgets/error_message.dart';
import 'package:mov_id/ui/widgets/selectable_box.dart';

class SelectSeatPage extends StatefulWidget {
  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  Ticket ticket;
  var priceNormalSeat = 35000;
  var priceCoupleSeat = 60000;

  List<String> _bookedSeat = [];
  List<String> _selectedSeat = List<String>();
  var totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    var argument =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    ticket = argument['ticket'];
    _bookedSeat = argument['booked_seats'] as List<String> ?? [];

    return Scaffold(
      extendBodyBehindAppBar: true,
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            width: ConstantVariable.deviceWidth(context),
            decoration: BoxDecoration(
              color: ConstantVariable.accentColor4,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  ConstantVariable.imageBaseUrl
                      .replaceAll('%size%', 'w780')
                      .replaceAll(
                        '/%path%',
                        (ticket.movieDetail.backdropPath == null ||
                                ticket.movieDetail.backdropPath == '')
                            ? ticket.movieDetail.posterPath
                            : ticket.movieDetail.backdropPath,
                      ),
                ),
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              width: ConstantVariable.deviceWidth(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                left: 24,
                bottom: 24,
              ),
              child: Text(
                ticket.movieDetail.title,
                style: ConstantVariable.textFont.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            margin: EdgeInsets.only(top: 15, bottom: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/screen.png'),
              ),
            ),
          ),
          _costumSeat(context),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 120,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: ConstantVariable.textFont.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'id_ID',
                      decimalDigits: 0,
                      symbol: 'IDR ',
                    ).format(totalPrice),
                    style: ConstantVariable.textFont.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: ConstantVariable.deviceWidth(context),
              child: RaisedButton(
                elevation: 0,
                color: ConstantVariable.accentColor2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  _goToComfirmationPage(context);
                },
                child: Text(
                  'Continue to Book',
                  style: ConstantVariable.textFont.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _costumSeat(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: [
          for (var i = 0; i < 5; i++)
            for (var j = 0; j < 7; j++)
              Padding(
                padding: EdgeInsets.only(right: (j == 3) ? 15 : 0),
                child: SelectableBox(
                  height: 40,
                  width: (ConstantVariable.deviceWidth(context) - 70) / 8,
                  title: "${String.fromCharCode(i + 65)}${j + 1}",
                  isEnable: !(_bookedSeat
                      .contains('${String.fromCharCode(i + 65)}${j + 1}')),
                  isSelected: _selectedSeat
                      .contains('${String.fromCharCode(i + 65)}${j + 1}'),
                  onTap: () {
                    setState(() {
                      if (_selectedSeat
                          .contains('${String.fromCharCode(i + 65)}${j + 1}')) {
                        _selectedSeat
                            .remove('${String.fromCharCode(i + 65)}${j + 1}');
                      } else {
                        _selectedSeat
                            .add('${String.fromCharCode(i + 65)}${j + 1}');
                      }
                      calculatePrice();
                    });
                  },
                ),
              ),
          for (var j = 0; j < 4; j++)
            SelectableBox(
              height: 40,
              width: (ConstantVariable.deviceWidth(context) - 80) / 4,
              title: "${String.fromCharCode(5 + 65)}${j + 1}",
              isEnable: !(_bookedSeat
                  .contains('${String.fromCharCode(5 + 65)}${j + 1}')),
              isSelected: _selectedSeat
                  .contains('${String.fromCharCode(5 + 65)}${j + 1}'),
              onTap: () {
                setState(() {
                  if (_selectedSeat
                      .contains('${String.fromCharCode(5 + 65)}${j + 1}')) {
                    _selectedSeat
                        .remove('${String.fromCharCode(5 + 65)}${j + 1}');
                  } else {
                    _selectedSeat.add('${String.fromCharCode(5 + 65)}${j + 1}');
                  }
                  calculatePrice();
                });
              },
            ),
        ],
      ),
    );
  }

  void calculatePrice() {
    //*
    totalPrice = 0;
    for (var seat in _selectedSeat) {
      if (seat.contains('F')) {
        totalPrice += priceCoupleSeat;
      } else {
        totalPrice += priceNormalSeat;
      }
    }
  }

  void _goToComfirmationPage(BuildContext context) {
    _selectedSeat.sort();
    ticket = ticket.copywith(totalPrice: totalPrice, seats: _selectedSeat);
    if (_selectedSeat.length != 0) {
      Navigator.pushNamed(context, '/booking_confirmation_page', arguments: {
        'ticket': ticket,
        'booked_seat': _bookedSeat,
      });
    } else {
      errorMessage(
        message: 'Please select seat to watch first !',
        context: context,
      );
    }
  }
}
