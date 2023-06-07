import 'package:bloc/bloc.dart';
import 'package:deliveat/bloc/login_bloc/login_state.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../repositories/user_repository.dart';
import 'package:deliveat/domain/utils/validators.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.initial()) {
    on<LoginEmailChange>(_mapLoginEmailChangeToState);
    on<LoginPasswordChanged>(_mapLoginPasswordChangeToState);
    on<LoginWithCredentialsPressed>(_mapLoginWithCredentialsPressedToState);
  }

  Future<void> _mapLoginEmailChangeToState(LoginEmailChange event, Emitter<LoginState> emit) async {
    emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
  }

  Future<void> _mapLoginPasswordChangeToState(LoginPasswordChanged event, Emitter<LoginState> emit) async {
    emit(state.update(isPasswordValid: Validators.isPasswordValid(event.password)));
  }

  Future<void> _mapLoginWithCredentialsPressedToState(LoginWithCredentialsPressed event, Emitter<LoginState> emit) async {
    emit(LoginState.loading());
    try {
      _userRepository.signInWithCredentials(event.email, event.password);
    } catch (_) {
      emit(LoginState.failure());
    }
  }
}
