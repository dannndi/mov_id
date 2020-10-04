import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/models/cinema.dart';
import 'package:mov_id/core/providers/movie_provider.dart';
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
        _titleColor = Colors.white;
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

            var movie = movieProvider.movieDetail;
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
                  child: _generateStar(movie.voteAverage),
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
                // (movie.adult)
                (true)
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
                  height: 200,
                  width: ConstantVariable.deviceWidth(context) - 40,
                  margin: EdgeInsets.all(20),
                  child: (_state == 'schedule')
                      ? _schedule()
                      : _overView(movie.overView),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _schedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Day on',
          style: ConstantVariable.textFont.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 100,
          width: ConstantVariable.deviceWidth(context) - 40,
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
        Text(overview),
      ],
    );
  }

  Widget _generateStar(double rating) {
    List<Widget> list = List();

    for (var i = 0; i < 5; i++) {
      if (i < (rating / 2).round()) {
        list.add(Icon(
          Icons.star,
          color: Colors.amber,
          size: 15,
        ));
      } else {
        list.add(Icon(
          Icons.star_border,
          color: Colors.amber,
          size: 15,
        ));
      }
    }

    return Row(
      children: [
        ...list,
        SizedBox(
          width: 10,
        ),
        Text(
          rating.toString(),
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
}
