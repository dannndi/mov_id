import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/models/ticket.dart';
import 'package:mov_id/core/providers/user_provider.dart';
import 'package:mov_id/core/services/firebase_storage_services.dart';
import 'package:mov_id/ui/widgets/generate_rating_stars.dart';
import 'package:provider/provider.dart';
import '../../core/extensions/datetime_extension.dart';

class BookingConfirmationPage extends StatefulWidget {
  @override
  _BookingConfirmationPageState createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  Ticket ticket;
  String userId = '';
  String userName = '';

  List<String> bookedSeat;
  @override
  Widget build(BuildContext context) {
    var argument =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    ticket = argument['ticket'];
    bookedSeat = argument['booked_seat'] ?? [];
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
            ),
          ),
          _detailTicket(context),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          //get id and user name
          userId = userProvider.userApp.id;
          userName = userProvider.userApp.name;

          return Container(
            height: 165,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Wallet',
                        style: ConstantVariable.textFont.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          decimalDigits: 0,
                          symbol: 'IDR ',
                        ).format(userProvider.userApp.balance),
                        style: ConstantVariable.textFont.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: ConstantVariable.textFont.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          decimalDigits: 0,
                          symbol: 'IDR ',
                        ).format(ticket.totalPrice),
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
                    color: userProvider.userApp.balance > ticket.totalPrice
                        ? ConstantVariable.accentColor2
                        : Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      userProvider.userApp.balance > ticket.totalPrice
                          ? _confirmBooking(context)
                          : _topUpWallet(context);
                    },
                    child: Text(
                      userProvider.userApp.balance > ticket.totalPrice
                          ? 'Confirm Booking'
                          : 'Top up Wallet',
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
          );
        },
      ),
    );
  }

  void _confirmBooking(BuildContext context) async {
    ticket = ticket.copywith(
      id: userId,
      username: userName,
      dateOfBuying: DateTime.now(),
    );

    await FirebaseStorageServices.addUserTicket(ticket, oldSeat: bookedSeat);
    print('addededd');
    // var listTicket = await FirebaseStorageServices.getUserTicket(userId);

    // for (var item in listTicket) {
    //   print(item.bookingCode);
    //   print(ticket.userId);
    // }
  }

  void _topUpWallet(BuildContext context) {
    print('topup');
  }

  Widget _detailTicket(BuildContext context) {
    return Container(
      width: ConstantVariable.deviceWidth(context) - 20,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ConstantVariable.accentColor1,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      ConstantVariable.imageBaseUrl
                          .replaceAll('%size%', 'w154')
                          .replaceAll(
                            '/%path%',
                            (ticket.movieDetail.posterPath == null ||
                                    ticket.movieDetail.posterPath == '')
                                ? ticket.movieDetail.backdropPath
                                : ticket.movieDetail.posterPath,
                          ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.movieDetail.title,
                      style: ConstantVariable.textFont.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ticket.movieDetail.genres.join(', '),
                      style: ConstantVariable.textFont,
                    ),
                    generateStar(ticket.movieDetail.voteAverage),
                    Text(
                      '${ticket.movieDetail.runTime} Minute',
                      style: ConstantVariable.textFont,
                    ),
                    //empty space
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(color: Colors.grey, height: 1),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cinema',
                style: ConstantVariable.textFont.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${ticket.cinema.name}',
                style: ConstantVariable.textFont,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date',
                style: ConstantVariable.textFont.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${ticket.bookedDate.fullDate}',
                style: ConstantVariable.textFont,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seat Number',
                style: ConstantVariable.textFont.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  ticket.seats.join(', '),
                  style: ConstantVariable.textFont,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Price per Seat',
            style: ConstantVariable.textFont.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (ticket.seats
                  .where((seat) => seat.contains(new RegExp(r'[A-E]')))
                  .length >
              0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '(Normal seat)',
                  style: ConstantVariable.textFont.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${ticket.seats.where((seat) => seat.contains(new RegExp(r'[A-E]'))).length} x 35.000',
                  style: ConstantVariable.textFont.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          if (ticket.seats.where((seat) => seat.contains('F')).length > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '(Couple seat)',
                  style: ConstantVariable.textFont.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${ticket.seats.where((seat) => seat.contains('F')).length} x 60.000',
                  style: ConstantVariable.textFont.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: ConstantVariable.textFont.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                NumberFormat.currency(
                  locale: 'id_ID',
                  decimalDigits: 0,
                  symbol: 'IDR ',
                ).format(ticket.totalPrice),
                style: ConstantVariable.textFont,
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
