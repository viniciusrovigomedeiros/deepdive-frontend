import 'package:deepdive/core/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
import '../api/sendAudio.dart';
import '../model/SendAudioRequest.dart';

final sendAudioEndpointProvider = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: baseURL,
  ));
  return SendAudioEndPoint(dio);
});

final sendAudioRepositoryProvider = Provider(
  (ref) => SendAudioRepository(
    sendAudioEndPoint: ref.read(sendAudioEndpointProvider),
  ),
);

final sendAudioUseCase = Provider((ref) {
  return SendAudioUseCase(
    repository: ref.read(sendAudioRepositoryProvider),
  );
});

enum SendAudioState { loggedOut, loading, loggedIn, error }

class SendAudioStateController extends StateNotifier<SendAudioState> {
  SendAudioStateController(
    this._read,
    this.audio,
  ) : super(SendAudioState.loggedOut);

  final Reader _read;
  var audio;

  static final provider =
      StateNotifierProvider<SendAudioStateController, SendAudioState>(
    (ref) => SendAudioStateController(ref.read, null),
  );

  Future sendAudio(SendAudioRequest request) async {
    audio = await _read(sendAudioUseCase).execute(request);

    return audio!;
  }
}
