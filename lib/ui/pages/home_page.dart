import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/models/movie.dart';
import 'package:mov_id/core/models/user.dart';
import 'package:mov_id/core/providers/movie_provider.dart';
import 'package:mov_id/core/providers/user_provider.dart';
import 'package:mov_id/core/services/base_services.dart';
import 'package:mov_id/ui/widgets/error_message.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //userfirebase
  User fireUser;
  UserApp userApp;
  Color _backGroundColor = ConstantVariable.accentColor4;
  Color _appBarColor = ConstantVariable.accentColor4;
  Color _appBarTextColor = Colors.white;
  double _elevation = 0;

  ScrollController _scrollController = ScrollController();
  _scrollListner() {
    if (_scrollController.offset >= 60) {
      setState(() {
        _backGroundColor = Colors.transparent;
        _appBarColor = Colors.white;
        _appBarTextColor = Colors.black;
        _elevation = 2;
      });
    } else {
      setState(() {
        _backGroundColor = ConstantVariable.accentColor4;
        _appBarColor = ConstantVariable.accentColor4;
        _appBarTextColor = Colors.white;
        _elevation = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListner);
  }

  @override
  Widget build(BuildContext context) {
    fireUser = Provider.of<User>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/logo.png',
            width: 25,
            height: 25,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Movie ID',
          style: ConstantVariable.textFont.copyWith(
            color: _appBarTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: _appBarColor,
        elevation: _elevation,
        actions: [
          IconButton(
            iconSize: 25,
            icon: Icon(
              MdiIcons.bellOutline,
              color: _appBarTextColor,
            ),
            onPressed: () {
              errorMessage(
                message: 'Not ready yet !',
                context: context,
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _background(context),
          SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _balanceInfo(context),
                  _nowPlaying(context),
                  _comingSoon(context),
                ],
              ),
            ),
          ),
          // _appbar(context),
        ],
      ),
    );
  }

  Widget _background(BuildContext context) {
    return Container(
      height: ConstantVariable.deviceHeight(context) * 0.22,
      width: ConstantVariable.deviceWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        color: _backGroundColor,
      ),
    );
  }

  Widget _appbar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25),
      height: 75,
      color: _appBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Movie ID',
            style: ConstantVariable.textFont.copyWith(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _balanceInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      // height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          //* check if its picture to upload
          if (ConstantVariable.profilePictureToUpdate != null) {
            BaseServices.uploadImageToFireStore(
                    ConstantVariable.profilePictureToUpdate)
                .then((downloadUrl) {
              ConstantVariable.profilePictureToUpdate = null;

              //* update user Info
              userProvider.updateUser(profilePicture: downloadUrl);
            });
          }

          //*
          //*
          userApp = userProvider.userApp;
          if (userApp == null) {
            userProvider.getUser(userId: fireUser.uid);
            return Container(
              height: 130,
              child: SpinKitThreeBounce(
                color: ConstantVariable.accentColor1,
                size: 15,
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        MdiIcons.mapMarkerOutline,
                        size: 20,
                        color: Colors.black,
                      ),
                      SizedBox(width: 3),
                      Text(
                        'Indonesia',
                        style: ConstantVariable.textFont.copyWith(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Divider(),
              Text(
                'Hello,\n${userApp.name}',
                style: ConstantVariable.textFont.copyWith(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        MdiIcons.walletOutline,
                        size: 20,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5),
                      Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          decimalDigits: 0,
                          symbol: 'IDR ',
                        ).format(userApp.balance),
                        style: ConstantVariable.textFont.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: OutlineButton.icon(
                      borderSide: BorderSide(
                        color: ConstantVariable.primaryColor,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/top_up_page');
                      },
                      icon: Icon(
                        MdiIcons.walletPlusOutline,
                        size: 15,
                        color: ConstantVariable.primaryColor,
                      ),
                      label: Text(
                        'Top up',
                        style: ConstantVariable.textFont.copyWith(
                          color: ConstantVariable.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _nowPlaying(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Now Playing',
                  style: ConstantVariable.textFont.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    errorMessage(message: 'Coming soon', context: context);
                  },
                  child: Text(
                    'More >',
                    style: ConstantVariable.textFont.copyWith(
                      fontSize: 16,
                      color: ConstantVariable.accentColor1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: ConstantVariable.deviceWidth(context),
            height: 330,
            child: Consumer<MovieProvider>(
              builder: (context, movieProvider, _) {
                if (movieProvider.nowPlayingMovies == null) {
                  movieProvider.getNowPlaying();
                  return Center(
                    child: SpinKitThreeBounce(
                      color: ConstantVariable.accentColor1,
                      size: 20,
                    ),
                  );
                }
                var movies = movieProvider.nowPlayingMovies;
                return CarouselSlider.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) =>
                      _nowPlayingItem(context, index, movies),
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    initialPage: 1,
                    aspectRatio: 0.9,
                    viewportFraction: 0.5,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _comingSoon(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Coming Soon',
                  style: ConstantVariable.textFont.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    errorMessage(message: 'Coming soon', context: context);
                  },
                  child: Text(
                    'More >',
                    style: ConstantVariable.textFont.copyWith(
                      fontSize: 16,
                      color: ConstantVariable.accentColor1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: ConstantVariable.deviceWidth(context),
            height: 330,
            child: Consumer<MovieProvider>(
              builder: (context, movieProvider, _) {
                if (movieProvider.comingSoonMovies == null) {
                  movieProvider.getComingSoon();
                  return Center(
                    child: SpinKitThreeBounce(
                      color: ConstantVariable.accentColor1,
                      size: 20,
                    ),
                  );
                }
                var movies = movieProvider.comingSoonMovies;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) =>
                      _comingSoonItem(context, index, movies),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  //nowPlaying items
  Widget _nowPlayingItem(
    BuildContext context,
    int index,
    List<Movie> movies,
  ) {
    return GestureDetector(
      onTap: () {
        Provider.of<MovieProvider>(context, listen: false).clearMovieDetail();
        Navigator.pushNamed(
          context,
          '/movie_detail_page',
          arguments: movies[index].id,
        );
      },
      child: Container(
        height: 330,
        width: 190,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 270,
              width: 190,
              margin: EdgeInsets.only(
                bottom: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ConstantVariable.primaryColor.withOpacity(0.5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    ConstantVariable.imageBaseUrl
                        .replaceAll('%size%', 'w154')
                        .replaceAll(
                          '/%path%',
                          movies[index].posterPath,
                        ),
                  ),
                ),
              ),
            ),
            Container(
              width: 190,
              child: Center(
                child: Text(
                  movies[index].title,
                  style: ConstantVariable.textFont.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
            Container(
              width: 190,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 15),
                        Text(
                          movies[index].voteAverage.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.yellow,
                          Colors.black,
                        ],
                        stops: [
                          0.4,
                          1,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'XXI',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'CGV',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (movies[index].adult)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        '18+',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _comingSoonItem(BuildContext context, int index, List<Movie> movies) {
    return Container(
      height: 330,
      width: 190,
      margin: EdgeInsets.only(
        left: index == 0 ? 20 : 5,
        right: index == movies.length - 1 ? 20 : 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 270,
            width: 190,
            margin: EdgeInsets.only(
              bottom: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ConstantVariable.primaryColor.withOpacity(0.5),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  ConstantVariable.imageBaseUrl
                      .replaceAll('%size%', 'w154')
                      .replaceAll(
                        '/%path%',
                        movies[index].posterPath,
                      ),
                ),
              ),
            ),
          ),
          Container(
            width: 190,
            child: Center(
              child: Text(
                movies[index].title,
                style: ConstantVariable.textFont.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          Container(
            width: 190,
            child: Center(
              child: Text(
                'Release on ${movies[index].releaseDate}',
                style: ConstantVariable.textFont.copyWith(
                  fontSize: 15,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
