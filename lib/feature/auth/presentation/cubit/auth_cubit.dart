import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/feature/auth/data/models/register_init_model.dart';
import 'package:flutter_application_1/feature/auth/data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial());

  Future<void> registerInit({
    required String fullName,
    required String phone,
  }) async {
    emit(AuthLoading());

    final model = RegisterInitModel(
      fullName: fullName,
      phone: phone,
    );

    final response = await _authRepository.registerInit(model);

    if (isClosed) return;

    if (response.isSuccess) {
      emit(AuthSuccess(message: response.message ?? 'Success'));
    } else {
      emit(AuthFailure(message: response.message ?? 'Something went wrong'));
    }
  }

  Future<void> verifyOtp(String code) async {
    emit(AuthLoading());
    final response = await _authRepository.verifyOtp(code);
    if (isClosed) return;
    if (response.isSuccess) {
      emit(AuthSuccess(message: response.message ?? 'Verification Successful'));
    } else {
      emit(AuthFailure(message: response.message ?? 'Verification Failed'));
    }
  }

  Future<void> registerComplete(String passcode) async {
    emit(AuthLoading());
    final response = await _authRepository.registerComplete(passcode);
    if (isClosed) return;
    if (response.isSuccess) {
      emit(AuthSuccess(message: response.message ?? 'Registration Completed'));
    } else {
      emit(AuthFailure(message: response.message ?? 'Registration Failed'));
    }
  }

  Future<void> loginInit(String phone) async {
    emit(AuthLoading());
    final response = await _authRepository.loginInit(phone);
    if (isClosed) return;
    if (response.isSuccess) {
      emit(AuthSuccess(message: response.message ?? 'OTP Sent'));
    } else {
      emit(AuthFailure(message: response.message ?? 'Login Init Failed'));
    }
  }

  Future<void> loginComplete(String passcode) async {
    emit(AuthLoading());
    final response = await _authRepository.loginComplete(passcode);
    if (isClosed) return;
    if (response.isSuccess) {
      emit(AuthSuccess(message: response.message ?? 'Login Successful'));
    } else {
      emit(AuthFailure(message: response.message ?? 'Login Failed'));
    }
  }

  Future<void> changePasscode(String passcode) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.changePasscode(passcode);
      if (isClosed) return;
      if (response.isSuccess) {
        emit(AuthSuccess(
            message: response.message ?? 'Passcode changed successfully'));
      } else {
        emit(AuthFailure(
            message: response.message ?? 'Failed to change passcode'));
      }
    } catch (e) {
      if (!isClosed) emit(AuthFailure(message: e.toString()));
    }
  }
}
