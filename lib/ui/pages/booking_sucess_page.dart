import 'package:flutter/material.dart';
import 'package:mov_id/core/base/constant_variable.dart';

class BookingSuccessPage extends StatefulWidget {
  @override
  _BookingSuccessPageState createState() => _BookingSuccessPageState();
}

class _BookingSuccessPageState extends State<BookingSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            //close
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Booking Successfull',
          style: ConstantVariable.textFont.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                child: Image(
                  image: AssetImage('assets/images/ticket_done.png'),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Thank you for Purchasing',
                style: ConstantVariable.textFont.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'You have successfully bought the Ticket, \n please check on menu ticket',
                style: ConstantVariable.textFont.copyWith(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 70),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Go to Home Page',
                  style: ConstantVariable.textFont.copyWith(
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
