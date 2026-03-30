import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:market_ease/core/data_source/remote/api_config.dart';
import 'package:market_ease/core/data_source/remote/api_service.dart';
import 'package:market_ease/core/services/secure_storage.dart';
import 'package:market_ease/core/utils/app_constants.dart';
import 'package:market_ease/features/auth/login/models/login_model.dart';

import '../../../../core/data_source/remote/errors/failures.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiService apiService;
  LoginCubit(this.apiService) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final response = await apiService.post(
        endPoint: ApiEndPoints.login,
        data: {"email": email, "password": password},
      );

      // response.data is the actual JSON map returned by the API
      final loginModel = LoginModel.fromJson(response.data);

      if (loginModel.token != null) {
        final decodedToken = JwtDecoder.decode(loginModel.token!);

        // Save token and userId securely
        await SecureStorage.save(
          key: AppConstants.tokenKey,
          value: loginModel.token!,
        );
        await SecureStorage.save(
          key: AppConstants.userId,
          value: decodedToken["id"]?.toString() ?? "",
        );

        emit(LoginSuccess());
      } else {
        emit(LoginFailure(errorMessage: "Unexpected response: Token is missing"));
      }
    } catch (e) {
      if (e is DioException) {
        emit(
          LoginFailure(
            errorMessage: ServerFailure.fromDioException(e).errorMessage,
          ),
        );
      } else {
        emit(LoginFailure(errorMessage: e.toString()));
      }
    }
  }
}
