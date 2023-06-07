import 'package:deliveat/l10n/L10n.dart';
import 'package:deliveat/local_provider.dart';
import 'package:deliveat/presentation/Pages/ProfilePage.dart';
import 'package:deliveat/theme/ThemeNotifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: unused_import
// ignore: unused_import
import 'package:deliveat/presentation/Pages/HomePage.dart';

// ignore: unused_import
import 'package:deliveat/presentation/Pages/CartPage.dart';
import 'package:deliveat/presentation/Pages/Auth/login/login_screen.dart';
import 'package:deliveat/presentation/Pages/NavBarPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:food_app/presentation/Pages/AuthPage.dart';

// ignore: unused_import
import 'package:deliveat/presentation/SplashScreen/SplashScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'bloc/auth_bloc.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/auth_bloc/auth_event.dart';
import 'bloc/auth_bloc/auth_state.dart';
import 'bloc/bloc_observer.dart';
import 'bloc/repositories/user_repository.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:deliveat/theme/CustomTheme.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? selectedTheme = prefs.getString('theme');

  ThemeData appTheme;

  switch (selectedTheme) {
    case 'light':
      appTheme = CustomTheme.lightTheme;
      break;
    case 'dark':
      appTheme = CustomTheme.darkTheme;
      break;
    case 'custom':
      appTheme = CustomTheme.customTheme;
      break;
    default:
      appTheme = CustomTheme.lightTheme;
  }

  runApp(
    BlocProvider(
      create: (context) => AuthBloc(
        userRepository: userRepository,
      )..add(AuthStarted()),
      child: MyApp(
        userRepository: userRepository,
        theme:appTheme,
      ),
    ),
  );
}

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);
// class MyApp extends StatelessWidget with WidgetsBindingObserver {
//   final UserRepository _userRepository;
//   ThemeData theme;
//
//   MyApp({required UserRepository userRepository, required this.theme})
//       : _userRepository = userRepository;
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ThemeNotifier>(
//         create: (_) => ThemeNotifier(),
//       child: Consumer<ThemeNotifier>(
//         builder: (context, ThemeNotifier themeNotifier,child){
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme:  theme,
//             localizationsDelegates: [
//               AppLocalizations.delegate,
//               GlobalMaterialLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//             ],
//             supportedLocales: L10n.all,
//             home: BlocBuilder<AuthBloc, AuthState>(
//               builder: (context, state) {
//                 if (state is AuthFailure) {
//                   return LoginScreen(
//                     userRepository: _userRepository,
//                   );
//                 }
//
//                 if (state is AuthSuccess) {
//                   return NavBar(
//                     user: state.firebaseUser,
//                   );
//                 }
//
//                 return Scaffold(
//                   appBar: AppBar(),
//                   body: const Center(
//                     child: Text("Error"),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
//   }
class MyApp extends StatelessWidget with WidgetsBindingObserver {
  final UserRepository _userRepository;
  ThemeData theme;

  MyApp({required UserRepository userRepository, required this.theme})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(
          create: (_) => LocaleProvider(),
        ),
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(),
        ),
      ],
      child: Consumer2<LocaleProvider, ThemeNotifier>(
        builder: (context, localeProvider, themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeNotifier.theme,
            locale: localeProvider.locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            initialRoute: '/profile',
            routes: {
              '/profile': (context) => ProfilePage(),
              // Add other routes as needed
            },
          );
        },
      ),
    );
  }
}



