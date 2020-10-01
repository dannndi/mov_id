import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/ui/pages/home_page.dart';
import 'package:mov_id/ui/pages/profile_page.dart';
import 'package:mov_id/ui/pages/ticket_page.dart';
import 'package:mov_id/ui/pages/wallet_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _pages = [
    HomePage(),
    TicketPage(),
    WalletPage(),
    ProfilePage(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: ConstantVariable.accentColor4,
        unselectedItemColor: ConstantVariable.accentColor3.withOpacity(0.7),
        selectedIconTheme: IconThemeData(
          size: 30,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.homeOutline),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.ticketConfirmationOutline),
            title: Text('Ticket'),
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.walletOutline),
            title: Text('Wallet'),
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.accountCircleOutline),
            title: Text('Account'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
