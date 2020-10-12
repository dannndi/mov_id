import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/providers/user_provider.dart';
import 'package:mov_id/core/services/base_services.dart';
import 'package:mov_id/core/services/firebase_auth_services.dart';
import 'package:mov_id/ui/widgets/pick_image.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile',
          style: ConstantVariable.textFont.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'logout') {
                FirebaseAuthServices.logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login_page', (route) => false);
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _background(context),
          _content(context),
        ],
      ),
    );
  }

  Widget _background(BuildContext context) {
    return Container(
      height: ConstantVariable.deviceHeight(context) * 0.25,
      color: ConstantVariable.accentColor4,
    );
  }

  Widget _content(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 150,
                  width: 150,
                  margin: EdgeInsets.only(
                    top: (ConstantVariable.deviceHeight(context) * 0.25) - 75,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (userProvider.userApp.profilePicture != '' ||
                              userProvider.userApp.profilePicture != null)
                          ? NetworkImage(userProvider.userApp.profilePicture)
                          : NetworkImage(
                              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                            ),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        pickImage(
                          context: context,
                          image: (image) async {
                            if (image != null) {
                              var path =
                                  await BaseServices.uploadImageToFireStore(
                                image,
                              );
                              userProvider.updateUser(profilePicture: path);
                            }
                          },
                        );
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: ConstantVariable.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            MdiIcons.cameraOutline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 60),
                height: 60,
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: ConstantVariable.primaryColor.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          MdiIcons.account,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Name',
                          style: ConstantVariable.textFont.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          userProvider.userApp.name,
                          style: ConstantVariable.textFont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 60,
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          MdiIcons.email,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Email',
                          style: ConstantVariable.textFont.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          userProvider.userApp.email,
                          style: ConstantVariable.textFont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 60,
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: ConstantVariable.accentColor2.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          MdiIcons.flag,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Language',
                          style: ConstantVariable.textFont.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          userProvider.userApp.language,
                          style: ConstantVariable.textFont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }
}
