import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deliveat/presentation/Pages/HomePage.dart';
import 'package:deliveat/utils/Authentication.dart';
import 'package:deliveat/widgets/GoogleSignInButton.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../bloc/login_bloc/login_bloc.dart';
import '../../../../bloc/repositories/user_repository.dart';
import '../../../../domain/widgets/curved_widget.dart';
import 'package:deliveat/presentation/Pages/HomePage.dart';
import 'login_form.dart';
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;
  const LoginScreen({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository, super(key: key);
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),

      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xfff2cbd0),
                Color(0xfff4ced9),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                CurvedWidget(
                  child: Container(
                    padding: const EdgeInsets.only(top: 100, left: 50),
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.white.withOpacity(0.4),
                        ],
                      ),
                    ),
                    child:  Text(
                        AppLocalizations.of(context)!.login,
                      style: TextStyle(
                        fontSize: 40,
                        color: Color(0xff6a515e),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 230),
                  child: LoginForm(
                    userRepository: _userRepository,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
