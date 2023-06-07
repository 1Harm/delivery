// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_app/data/service/auth_service.dart';
//
// import '../../bloc/auth_bloc.dart';
//
// class AuthScreen extends StatefulWidget {
//   const AuthScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final authBloc=AuthBloc();
//     return BlocBuilder<AuthBloc,AuthState>(
//       bloc:auth,
//       builder: (context, state) {
//         return Scaffold(
//           body: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Form(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Log in",
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     TextFormField(
//                       controller: _emailController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter your email";
//                         }
//                         return null;
//                       },
//                       decoration: const InputDecoration(
//                         hintText: 'Email',
//                         focusColor: Colors.black,
//                         focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.black,
//                             width: 2,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     TextFormField(
//                       controller: _passwordController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter your password";
//                         }
//                         return null;
//                       },
//                       decoration: const InputDecoration(
//                         hintText: 'Password',
//                         focusColor: Colors.black,
//                         focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.black,
//                             width: 2,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     ElevatedButton(
//                       style:
//                       ElevatedButton.styleFrom(backgroundColor: Colors.black),
//                       onPressed: () => handleSubmit(),
//                       child: _loading
//                           ? const SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                           strokeWidth: 2,
//                         ),
//                       )
//                           : Text(_isLogin ? 'Login' : 'Register'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }