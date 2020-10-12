import 'package:flutter/material.dart';
import 'package:mov_id/core/base/constant_variable.dart';

class TopUpSuccessPage extends StatefulWidget {
  @override
  _TopUpSuccessPageState createState() => _TopUpSuccessPageState();
}

class _TopUpSuccessPageState extends State<TopUpSuccessPage> {
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
                  image: AssetImage('assets/images/top_up_done.png'),
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
                'You have successfully top up your Balance, \n have a good day',
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
