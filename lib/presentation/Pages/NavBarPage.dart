import 'package:firebase_auth/firebase_auth.dart';
import 'package:deliveat/presentation/Pages/CartPage.dart';
import 'package:deliveat/presentation/Pages/MapPage.dart';
import 'package:deliveat/presentation/Pages//HomePage.dart';
import 'package:deliveat/presentation/Pages/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key, required User user}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {


  int index = 0;

  final screenList=[
    HomePage(user:FirebaseAuth.instance.currentUser),
    const CartPage(),
    const MapPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:screenList[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() {
            this.index = index;
          }),
          destinations: [
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.bellConcierge,
                size: 30,
              ),
              label: AppLocalizations.of(context)!.restaraunts,
            ),
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.bagShopping,
                size: 30,
              ),
              label: AppLocalizations.of(context)!.cart,
            ),
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.mapLocation,
                size: 30,
              ),
              label: AppLocalizations.of(context)!.map,
            ),
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.userCircle,
                size: 30,
              ),
              label: AppLocalizations.of(context)!.account,
            ),
          ],
        ),
      ),
    );
  }
}
