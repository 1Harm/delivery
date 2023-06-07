import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../repositories/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthInitial()) {
    on<AuthStarted>((event, emit) => _mapAuthStartedToState());
    on<AuthLoggedIn>((event, emit) => _mapAuthLoggedInToState());
    on<AuthLoggedOut>((event, emit) => _mapAuthLoggedOutToState());
  }

  Future<void> _mapAuthLoggedOutToState() async {
    emit(AuthFailure());
    _userRepository.signOut();
  }

  Future<void> _mapAuthLoggedInToState() async {
    emit(AuthSuccess(await _userRepository.getUser()));
  }

  Future<void> _mapAuthStartedToState() async {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final firebaseUser = await _userRepository.getUser();
      emit(AuthSuccess(firebaseUser));
    } else {
      emit(AuthFailure());
    }
  }
}