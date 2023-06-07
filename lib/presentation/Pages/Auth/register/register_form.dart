
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deliveat/presentation/Pages/HomePage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../bloc/auth_bloc/auth_bloc.dart';
import '../../../../bloc/auth_bloc/auth_event.dart';
import '../../../../bloc/registration_bloc/registration_bloc.dart';
import '../../../../bloc/registration_bloc/registration_event.dart';
import '../../../../bloc/registration_bloc/registration_state.dart';
import '../../../../domain/widgets/gradient_button.dart';
import 'package:crypto/crypto.dart';
class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  late RegisterBloc _registerBloc;
  String encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }
  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
               SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(AppLocalizations.of(context)!.firebaseError),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Registering...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(
            AuthLoggedIn(),
          );
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration:  InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: AppLocalizations.of(context)!.email,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? AppLocalizations.of(context)!.firebaseError : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration:  InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: AppLocalizations.of(context)!.password,
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? AppLocalizations.of(context)!.firebaseError : null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  GradientButton(
                    width: 150,
                    height: 45,
                    onPressed: () {
                      if (isButtonEnabled(state)) {
                        _onFormSubmitted();
                      }
                    },
                    text:  Text(
                      AppLocalizations.of(context)!.register,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onEmailChange() {
    _registerBloc.add(
      RegisterEmailChange(email: _emailController.text),
    );
  }

  void _onPasswordChange() {
    _registerBloc.add(
      RegisterPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      RegisterSubmitted(
          email: _emailController.text, password: _passwordController.text),
    );
  }

}
