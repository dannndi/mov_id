import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/models/ticket.dart';
import 'package:mov_id/ui/widgets/dashed_devider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/extensions/datetime_extension.dart';

class TicketDetailPage extends StatelessWidget {
  Ticket ticket;
  @override
  Widget build(BuildContext context) {
    ticket = ModalRoute.of(context).settings.arguments;
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
        centerTitle: true,
        title: Text(
          'Ticket',
          style: ConstantVariable.textFont.copyWith(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            SizedBox(height: ConstantVariable.deviceHeight(context) * 0.05),
            Container(
              height: ConstantVariable.deviceHeight(context) * 0.17,
              width: ConstantVariable.deviceWidth(context) - 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    ConstantVariable.imageBaseUrl
                        .replaceAll('%size%', 'w500')
                        .replaceAll(
                          '/%path%',
                          ticket.movieDetail.backdropPath ??
                              ticket.movieDetail.posterPath,
                        ),
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white70,
                      Colors.transparent,
                    ],
                    stops: [
                      0,
                      0.3,
                      0.8,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            ClipPath(
              clipper: BottomClipper(),
              child: Container(
                height: ConstantVariable.deviceHeight(context) * 0.25,
                width: ConstantVariable.deviceWidth(context) - 70,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Movie : ${ticket.movieDetail.title}',
                      style: ConstantVariable.textFont.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cinema',
                          style: ConstantVariable.textFont.copyWith(
                            fontSize: 14,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          ticket.cinema.name,
                          style: ConstantVariable.textFont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date',
                          style: ConstantVariable.textFont.copyWith(
                            fontSize: 14,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          ticket.bookedDate.fullDate,
                          style: ConstantVariable.textFont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'on ${ticket.bookedDate.time24}',
                        style: ConstantVariable.textFont.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Seat',
                          style: ConstantVariable.textFont.copyWith(
                            fontSize: 14,
                          ),
                          maxLines: 1,
                        ),
                        Container(
                          height: ConstantVariable.deviceHeight(context) * 0.1,
                          width: ConstantVariable.deviceWidth(context) - 150,
                          child: Text(
                            '${ticket.seats.join(', ')}',
                            style: ConstantVariable.textFont.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 5,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ClipPath(
              clipper: TopClipper(),
              child: Container(
                height: ConstantVariable.deviceHeight(context) * 0.15,
                width: ConstantVariable.deviceWidth(context) - 66,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    DashedDevider(
                      color: Colors.grey[200],
                      height: 2,
                    ),
                    Container(
                      height:
                          (ConstantVariable.deviceHeight(context) * 0.15) - 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Booking ID :',
                                style: ConstantVariable.textFont.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('${ticket.bookingCode.toUpperCase()}')
                            ],
                          ),
                          QrImage(
                            data: ticket.bookingCode,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            size: ConstantVariable.deviceWidth(context) * 0.2,
                            version: 4,
                            errorCorrectionLevel: QrErrorCorrectLevel.M,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              mini: true,
              child: Icon(
                MdiIcons.trashCanOutline,
                color: Colors.white,
              ),
              backgroundColor: ConstantVariable.accentColor1,
              onPressed: () {},
              elevation: 2,
              heroTag: 'trashcan',
            ),
            SizedBox(width: 15),
            FloatingActionButton(
              mini: true,
              child: Icon(
                MdiIcons.printer,
                color: Colors.white,
              ),
              backgroundColor: ConstantVariable.accentColor1,
              onPressed: () {},
              elevation: 2,
              heroTag: 'save',
            ),
            SizedBox(width: 15),
            FloatingActionButton(
              mini: true,
              child: Icon(
                MdiIcons.shareVariantOutline,
                color: Colors.white,
              ),
              backgroundColor: ConstantVariable.accentColor1,
              onPressed: () {},
              elevation: 2,
              heroTag: 'share',
            ),
          ],
        ),
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 15);
    path.quadraticBezierTo(15, size.height - 15, 15, size.height);
    path.lineTo(size.width - 15, size.height);
    path.quadraticBezierTo(
      size.width - 15,
      size.height - 15,
      size.width,
      size.height - 15,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, 15);
    path.quadraticBezierTo(15, 15, 15, 0);
    path.lineTo(size.width - 15, 0);
    path.quadraticBezierTo(size.width - 15, 15, size.width, 15);
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
