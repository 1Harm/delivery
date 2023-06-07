import 'package:deliveat/l10n/L10n.dart';
import 'package:deliveat/picker.dart';
import 'package:deliveat/presentation/Pages/HomePage.dart';
import 'package:deliveat/theme/CustomTheme.dart';
import 'package:deliveat/theme/ThemeNotifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:deliveat/bloc/auth_bloc/auth_event.dart';
import 'package:deliveat/presentation/Pages/Auth/login/login_screen.dart';
import 'package:deliveat/utils/Authentication.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:deliveat/local_provider.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  late ThemeData _currentTheme;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier themeNotifier, child) {
              return MaterialApp(
                locale: provider.locale,
                supportedLocales: L10n.all,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: themeNotifier.theme,
                // Access the theme property directly
                home: Scaffold(
                  body: Column(
                    children: [
                      Container(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: CircleAvatar(
                                radius: 30,
                                // backgroundImage: user?.imageUrl as ImageProvider,
                              ),
                            ),
                            Text(
                              currentUser != null
                                  ? '${currentUser?.email}'
                                  : 'Null',
                              style: const TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          themeNotifier.setTheme(CustomTheme.lightTheme);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('theme', 'light');
                        },
                        child: Text(AppLocalizations.of(context)!.switchToLightTheme),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          themeNotifier.setTheme(CustomTheme.darkTheme);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('theme', 'dark');
                        },
                        child: Text(AppLocalizations.of(context)!.switchToDarkTheme),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          themeNotifier.setTheme(CustomTheme.customTheme);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('theme', 'custom');
                        },
                        child: Text(AppLocalizations.of(context)!.switchToCustomTheme),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(AppLocalizations.of(context)!.sel),
                                content: LanguagePickerWidget(),
                              );
                            },
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.sel),
                      ),
                      Container(
                        height: 100,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                              child: Icon(
                                Icons.ac_unit_outlined,
                                size: 30,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.appearance,
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                              child: Icon(
                                Icons.accessibility_new,
                                size: 30,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.order,
                              style: TextStyle(
                                fontSize: 34,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                          },
                          child: Text(AppLocalizations.of(context)!.logOut),
                        ),
                      ),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(user: null),
                        ),
                      );                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              );
            },
          );
        },
      );
}
