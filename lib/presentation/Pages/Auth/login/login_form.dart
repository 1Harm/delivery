import 'package:deliveat/widgets/onClickGitHubLoginButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deliveat/bloc/auth_bloc/auth_bloc.dart';
import 'package:deliveat/bloc/auth_bloc/auth_event.dart';
import 'package:deliveat/bloc/login_bloc/login_bloc.dart';
import 'package:deliveat/bloc/repositories/user_repository.dart';
import 'package:deliveat/domain/widgets/gradient_button.dart';
import 'package:deliveat/utils/Authentication.dart';
import 'package:deliveat/widgets/GoogleSignInButton.dart';
import 'package:deliveat/widgets/MicrosoftSignInButton.dart';
import 'package:deliveat/widgets/GitHubSignInButton.dart';
import '../../../../bloc/login_bloc/login_state.dart';
import '../register/register_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;
  const LoginForm({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  late final LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(
            AuthLoggedIn(),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: AppLocalizations.of(context)!.email,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? AppLocalizations.of(context)!.invalidEmail : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: AppLocalizations.of(context)!.password,
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? AppLocalizations.of(context)!.invalidPassword : null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GradientButton(
                    width: 180,
                    height: 45,
                    onPressed: () {
                      if (isButtonEnabled(state)) {
                        _onFormSubmitted();
                      }
                    },
                    text: Text(
                      AppLocalizations.of(context)!.login,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GradientButton(
                    width: 180,
                    height: 45,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return RegisterScreen(
                              userRepository: widget._userRepository,
                            );
                          },
                        ),
                      );
                    },
                    text: Text(
                      AppLocalizations.of(context)!.register,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                  GradientButton(
                    width: 180,
                    height: 45,
                    onPressed: () async {
                      signInAnonymously();
                    },
                    text: Text(
                      AppLocalizations.of(context)!.signInAsGuest,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),


                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChange() {
    _loginBloc.add(
      LoginEmailChange(email: _emailController.text),
    );
  }

  void _onPasswordChange() {
    _loginBloc.add(
      LoginPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void signInAnonymously() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signInAnonymously().then((result) {
      setState(() {
        final User? user = result.user;
      });
    });
  }
}
