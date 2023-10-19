import 'package:deepdive/core/utils.dart';
import 'package:deepdive/login/api/AuthUser.dart';
import 'package:deepdive/login/model/AuthUserResponse.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
import '../model/AuthUserRequest.dart';

final authUserEndpointProvider = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: baseURL,
  ));
  return AuthUserEndPoint(dio);
});

final authUserRepositoryProvider = Provider(
  (ref) => AuthUserRepository(
    authUserEndPoint: ref.read(authUserEndpointProvider),
  ),
);

final authUserUseCase = Provider((ref) {
  return AuthUserUseCase(
    repository: ref.read(authUserRepositoryProvider),
  );
});

enum AuthUserState { loggedOut, loading, loggedIn, error }

class AuthUserStateController extends StateNotifier<AuthUserState> {
  AuthUserStateController(
    this._read,
    this.authLogin,
  ) : super(AuthUserState.loggedOut);

  final Reader _read;
  var authLogin;

  static final provider =
      StateNotifierProvider<AuthUserStateController, AuthUserState>(
    (ref) => AuthUserStateController(ref.read, null),
  );

  Future authUser(AuthUserRequest request) async {
    authLogin = await _read(authUserUseCase).execute(request);

    return authLogin;
  }

  AuthUserResponse? get user => authLogin as AuthUserResponse;
}
