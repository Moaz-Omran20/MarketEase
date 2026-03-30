import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_ease/core/data_source/remote/api_config.dart';
import 'package:market_ease/core/data_source/remote/api_service.dart';

import '../../../../core/data_source/remote/errors/failures.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.apiService) : super(SignupInitial());

  final ApiService apiService;

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    emit(SignupLoading());

    try {
      await apiService.post(
        endPoint: ApiEndPoints.signup,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "rePassword": confirmPassword,
          "phone": phone,
        },
      );
      emit(SignupSuccess());
    } catch (e) {
      if (e is DioException) {
        emit(SignupError(ServerFailure.fromDioException(e).errorMessage));
      } else {
        emit(SignupError(e.toString()));
      }
    }
  }
}
