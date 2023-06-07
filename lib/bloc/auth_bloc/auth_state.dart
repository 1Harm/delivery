import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props =>[];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState{
  final User firebaseUser;

  AuthSuccess(this.firebaseUser);

  @override
  List<Object?> get props =>[];
}


class AuthFailure extends AuthState{}