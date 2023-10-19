import 'package:deepdive/login/model/AuthUserResponse.dart';
import 'package:dio/dio.dart';
import '../model/AuthUserRequest.dart';

class AuthUserEndPoint {
  final Dio _dio;
  AuthUserEndPoint(this._dio);

  Future authUser(AuthUserRequest request) async {
    final data = {
      "email": request.email,
      "password": request.password,
    };
    try {
      var response = await _dio.post(
        '/auth',
        data: data,
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class AuthUserRepository {
  final AuthUserEndPoint authUserEndPoint;

  AuthUserRepository({required this.authUserEndPoint});

  Future authUser(AuthUserRequest request) async {
    final result = await authUserEndPoint.authUser(request);
    if (result.runtimeType == DioError) {
      return AuthUserResponse.fromJson(result.response.data);
    } else {
      return AuthUserResponse.fromJson(result);
    }
  }
}

class AuthUserUseCase {
  final AuthUserRepository repository;

  AuthUserUseCase({required this.repository});

  Future execute(AuthUserRequest request) async {
    final response = await repository.authUser(request);
    return response;
  }
}
