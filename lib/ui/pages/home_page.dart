import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/models/user.dart';
import 'package:mov_id/core/providers/movie_provider.dart';
import 'package:mov_id/core/providers/user_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    fireUser = Provider.of<User>(context);
    return Stack(
      children: [
        _background(context),
        SafeArea(
          child: Column(
            children: [
              _appbar(context),
              _balanceInfo(context),
              _nowPlaying(context),
            ],
          ),
        ),
      ],
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
        color: ConstantVariable.accentColor4,
      ),
    );
  }

  Widget _appbar(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Image.asset(
              'assets/images/logo.png',
              width: 25,
              height: 25,
            ),
          ),
          Text(
            'Movie ID',
            style: ConstantVariable.textFont.copyWith(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            iconSize: 25,
            icon: Icon(
              MdiIcons.bellOutline,
              color: Colors.white,
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
    );
  }

  Widget _balanceInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          userApp = userProvider.userApp;
          if (userApp == null) {
            userProvider.getUser(fireUser.uid);
            return SpinKitThreeBounce(
              color: ConstantVariable.accentColor1,
              size: 15,
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
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
                        errorMessage(
                          message: 'Not ready yet !',
                          context: context,
                        );
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
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                Text(
                  'More >',
                  style: ConstantVariable.textFont.copyWith(
                    fontSize: 16,
                    color: ConstantVariable.accentColor1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: ConstantVariable.deviceWidth(context),
            height: 280,
            child: Consumer<MovieProvider>(
              builder: (context, movieProvider, _) {
                var movies = movieProvider.nowPlayingMovies;
                if (movieProvider.nowPlayingMovies == null) {
                  movieProvider.getNowPlaying();
                  return Center(
                    child: SpinKitThreeBounce(
                      color: ConstantVariable.accentColor1,
                      size: 20,
                    ),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 230,
                          margin: EdgeInsets.only(
                            left: index == 0 ? 20 : 5,
                            right: index == movies.length - 1 ? 15 : 5,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                ConstantVariable.primaryColor.withOpacity(0.5),
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
                          width: 100,
                          padding: EdgeInsets.only(
                            left: index == 0 ? 20 : 5,
                            right: index == movies.length - 1 ? 15 : 5,
                            bottom: 10,
                          ),
                          child: Center(
                            child: Text(
                              movies[index].title + 'dasdsadas',
                              style: ConstantVariable.textFont.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
