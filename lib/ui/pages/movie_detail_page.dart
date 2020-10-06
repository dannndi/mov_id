import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/models/cinema.dart';
import 'package:mov_id/core/models/movie_detail.dart';
import 'package:mov_id/core/models/ticket.dart';
import 'package:mov_id/core/providers/movie_provider.dart';
import 'package:mov_id/ui/widgets/error_message.dart';
import 'package:mov_id/ui/widgets/generate_rating_stars.dart';
import 'package:mov_id/ui/widgets/selectable_box.dart';
import 'package:mov_id/ui/widgets/selectable_date.dart';
import 'package:mov_id/ui/widgets/toogle_text.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  int id;
  String title;
  Color _appbarColor = Colors.transparent;
  Color _titleColor = Colors.transparent;
  Color _arrowColor = Colors.black;

  ScrollController _scrollController = ScrollController();

  String _state = 'schedule';

  //* variable for shceduling
  List<DateTime> _availDate;
  List<int> _availHour;

  MovieDetail movie;
  DateTime _selectedDate;
  int _selectedHour;
  Cinema _selectedCinema;

  void _scrollListner() {
    if (_scrollController.offset > 100) {
      setState(() {
        _appbarColor = ConstantVariable.accentColor4;
        _titleColor = Colors.white;
        _arrowColor = Colors.white;
      });
    } else {
      setState(() {
        _appbarColor = Colors.transparent;
        _titleColor = Colors.transparent;
        _arrowColor = Colors.black;
        title = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListner);
    //generate list date and hour
    _availDate = List.generate(
      14,
      (index) => DateTime.now().add(Duration(days: index)),
    );
    _availHour = List.generate(7, (index) => 10 + (index * 2));
    //default selected Day
    _selectedDate = _availDate[0];
    _selectedCinema = dummyCinema[0];
  }

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: _arrowColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(title ?? '',
            style: ConstantVariable.textFont.copyWith(
              color: _titleColor,
              fontSize: 18,
            )),
        backgroundColor: _appbarColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Consumer<MovieProvider>(
          builder: (context, movieProvider, _) {
            if (movieProvider.movieDetail == null) {
              movieProvider.getMovieDetail(id);
              return Column(
                children: [
                  Container(
                    height: 250,
                    width: ConstantVariable.deviceWidth(context),
                    color: ConstantVariable.accentColor4,
                    child: Center(
                      child: SpinKitThreeBounce(
                        color: ConstantVariable.accentColor1,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              );
            }

            movie = movieProvider.movieDetail;
            title = movie.title;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
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
                              (movie.backdropPath == null ||
                                      movie.backdropPath == '')
                                  ? movie.posterPath
                                  : movie.backdropPath,
                            ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 20),
                  child: generateStar(movie.voteAverage),
                ),
                Container(
                  height: 90,
                  width: ConstantVariable.deviceWidth(context) - 40,
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        movie.title,
                        style: ConstantVariable.textFont.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        movie.genres.join(', '),
                        style: ConstantVariable.textFont.copyWith(),
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                      ),
                      _language(movie.language),
                      Text(
                        '${movie.runTime} Minutes',
                        style: ConstantVariable.textFont.copyWith(),
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
                (movie.adult)
                    ? Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Warning Adult Content 18+ !! \nThis movie may contain violence, harsh words, and sexual scenes! ',
                          style: ConstantVariable.textFont.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      ToogleText(
                        width: (ConstantVariable.deviceWidth(context) - 50) / 2,
                        text: 'Schedule',
                        space: 10,
                        isSelected: _state == 'schedule',
                        onTap: () {
                          setState(() {
                            _state = 'schedule';
                          });
                        },
                      ),
                      ToogleText(
                        width: (ConstantVariable.deviceWidth(context) - 50) / 2,
                        text: 'Info',
                        space: 10,
                        isSelected: _state == 'overview',
                        onTap: () {
                          setState(() {
                            _state = 'overview';
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: ConstantVariable.deviceWidth(context),
                  padding: EdgeInsets.all(20),
                  color: Colors.grey[100],
                  child: (_state == 'schedule')
                      ? _schedule()
                      : _overView(movie.overView),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _selectedHour == null
          ? SizedBox()
          : Container(
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
                  _selectSeatPage(context);
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
    );
  }

  Widget _schedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80,
          width: ConstantVariable.deviceWidth(context) - 40,
          margin: EdgeInsets.only(bottom: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _availDate.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: SelectableDate(
                  date: _availDate[index],
                  isSelected: _selectedDate == _availDate[index],
                  onTap: () {
                    setState(() {
                      _selectedDate = _availDate[index];
                    });
                  },
                ),
              );
            },
          ),
        ),
        Row(
          children: [
            Container(
              height: 40,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ConstantVariable.accentColor1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Cinema',
                style: ConstantVariable.textFont.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    color: ConstantVariable.accentColor1,
                  ),
                ),
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 20,
                    isExpanded: true,
                    elevation: 0,
                    value: _selectedCinema,
                    isDense: true,
                    dropdownColor: Colors.white,
                    items: dummyCinema
                        .map(
                          (cinema) => DropdownMenuItem(
                              child: Text(
                                cinema.name,
                                style: ConstantVariable.textFont.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              value: cinema),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCinema = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          'Regular 2D',
          style: ConstantVariable.textFont.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 15,
          runSpacing: 10,
          children: _availHour
              .map((hour) => SelectableBox(
                    height: 45,
                    width: (ConstantVariable.deviceWidth(context) - 70) / 3,
                    title: hour <= 9 ? '0$hour:00' : '$hour:00',
                    isEnable: hour > DateTime.now().hour ||
                        _selectedDate.day != DateTime.now().day,
                    isSelected: _selectedHour == hour,
                    onTap: () {
                      setState(() {
                        _selectedHour = hour;
                      });
                    },
                  ))
              .toList(),
        ),
        // avoid floating action button
        SizedBox(height: 60),
      ],
    );
  }

  Widget _overView(String overview) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: ConstantVariable.textFont
              .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Text(
          overview,
          style: ConstantVariable.textFont.copyWith(
            fontSize: 13,
            letterSpacing: 0.5,
            wordSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _language(String language) {
    var lg = '';
    switch (language) {
      case 'en':
        lg = 'English';
        break;
      case 'kr':
        lg = 'Korea';
        break;
      case 'id':
        lg = 'Indonesia';
        break;
      case 'jp':
        lg = 'Japanese';
        break;
      default:
        lg = 'English';
    }
    return Text(
      lg,
      style: ConstantVariable.textFont.copyWith(),
      maxLines: 1,
      textAlign: TextAlign.start,
      overflow: TextOverflow.clip,
    );
  }

  //* methode
  void _selectSeatPage(BuildContext context) {
    if (_selectedDate == null) {
      errorMessage(
          message: 'Please choose date in order to continue', context: context);
    } else if (_selectedCinema == null) {
      errorMessage(
          message: 'Please choose one cinema in order to continue',
          context: context);
    } else if (_selectedHour == null) {
      errorMessage(
          message: 'Please choose time in order to continue', context: context);
    } else {
      DateTime _date = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedHour,
      );

      //* Create new Ticket
      var ticket = Ticket(
        movieDetail: movie,
        cinema: _selectedCinema,
        bookedDate: _date,
      );

      //* Navigate
      Navigator.pushNamed(context, '/select_seat_page', arguments: ticket);
    }
  }
}
