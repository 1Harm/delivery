import 'package:bloc/bloc.dart';
import 'package:deliveat/bloc/registration_bloc/registration_event.dart';
import 'package:deliveat/bloc/registration_bloc/registration_state.dart';
import '../../domain/utils/validators.dart';
import '../repositories/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterState.initial()) {
    on<RegisterEmailChange>(_mapRegisterEmailChangeToState);
    on<RegisterPasswordChanged>(_mapRegisterPasswordChangeToState);
    on<RegisterSubmitted>(_mapRegisterSubmittedToState);
  }


  Future<void> _mapRegisterEmailChangeToState(
      RegisterEmailChange event, Emitter<RegisterState> emit) async {
    emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
  }

  Future<void> _mapRegisterPasswordChangeToState(
      RegisterPasswordChanged event, Emitter<RegisterState> emit) async {
    emit(state.update(isPasswordValid: Validators.isPasswordValid(event.password)));
  }

  Future<void> _mapRegisterSubmittedToState(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(RegisterState.loading());
    try {
      await _userRepository.signUp(event.email, event.password);
      emit(RegisterState.success());
    } catch (_) {
      emit(RegisterState.failure());
    }
  }
}
