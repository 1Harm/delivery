import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:deliveat/presentation/Pages/HomePage.dart';

import '../utils/Authentication.dart';

class MicrosoftSignInButton extends StatefulWidget {
  @override
  _MicrosoftSignInButton createState() => _MicrosoftSignInButton();
}

class _MicrosoftSignInButton extends State<MicrosoftSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      )
          : OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () async {
          setState(() {
            _isSigningIn = true;
          });

          User? user =
          await Authentication.signInWithGoogle(context: context);

          setState(() {
            _isSigningIn = false;
          });

          if (user != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(
                  user: user,
                ),
              ),
            );
          }
        },
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/microsoft_logo.png"),
                height: 35.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Microsoft',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}