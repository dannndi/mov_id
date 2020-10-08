import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/models/ticket.dart';
import 'package:mov_id/core/providers/ticket_provider.dart';
import 'package:mov_id/core/providers/user_provider.dart';
import 'package:mov_id/ui/widgets/toogle_text.dart';
import 'package:provider/provider.dart';
import '../../core/extensions/datetime_extension.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  var _state = 'New ticket';
  User fireUser;
  @override
  Widget build(BuildContext context) {
    fireUser = Provider.of<User>(context);
    // Provider.of<TicketProvider>(context, listen: false).clearTicket();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Ticket',
          style: ConstantVariable.textFont.copyWith(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
              ),
              color: Colors.white,
              child: Row(
                children: [
                  ToogleText(
                    width: (ConstantVariable.deviceWidth(context) - 50) / 2,
                    text: 'New Ticket',
                    space: 10,
                    isSelected: _state == 'New ticket',
                    onTap: () {
                      setState(() {
                        _state = 'New ticket';
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  ToogleText(
                    width: (ConstantVariable.deviceWidth(context) - 50) / 2,
                    text: 'Used Ticket',
                    space: 10,
                    isSelected: _state == 'Expired',
                    onTap: () {
                      setState(() {
                        _state = 'Expired';
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: _content(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Consumer2<UserProvider, TicketProvider>(
      builder: (context, userProvider, ticketProvider, _) {
        if (userProvider.userApp == null) {
          userProvider.getUser(userId: fireUser.uid);
          return Center(
            child: SpinKitThreeBounce(
              color: ConstantVariable.accentColor1,
              size: 15,
            ),
          );
        }
        //get new one
        if (ticketProvider.userTicket == null) {
          ticketProvider.getTicket(userId: fireUser.uid);
          return Center(
            child: SpinKitThreeBounce(
              color: ConstantVariable.accentColor1,
              size: 15,
            ),
          );
        }
        if (ticketProvider.userTicket.length == 0) {
          return Center(
            child: Text('You don\'t have ticket yet !'),
          );
        }

        var availTicket = ticketProvider.userTicket
            .where((ticket) => ticket.bookedDate.isAfter(DateTime.now()))
            .toList();

        var expiredTicket = ticketProvider.userTicket
            .where((ticket) => ticket.bookedDate.isBefore(DateTime.now()))
            .toList();

        return Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: _state == 'New ticket'
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: availTicket.length,
                  itemBuilder: (context, index) =>
                      _ticketItem(availTicket[index]),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: expiredTicket.length,
                  itemBuilder: (context, index) =>
                      _ticketItem(expiredTicket[index]),
                ),
        );
      },
    );
  }

  Widget _ticketItem(Ticket ticket) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: (ConstantVariable.deviceWidth(context) - 40) * 0.3,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  ConstantVariable.imageBaseUrl
                      .replaceAll('%size%', 'w154')
                      .replaceAll(
                        '/%path%',
                        ticket.movieDetail.posterPath,
                      ),
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            alignment: Alignment.centerRight,
            child: Container(
              width: (ConstantVariable.deviceWidth(context) - 40) * 0.3,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white70, Colors.transparent],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  stops: [0, 0.2, 0.8],
                ),
              ),
            ),
          ),
          Container(
            width: (ConstantVariable.deviceWidth(context) - 40) * 0.7,
            height: 120,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.movieDetail.title,
                  style: ConstantVariable.textFont.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ticket.cinema.name,
                  style: ConstantVariable.textFont.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${ticket.bookedDate.fullDate} \nOn ${ticket.bookedDate.time24}',
                  style: ConstantVariable.textFont.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
