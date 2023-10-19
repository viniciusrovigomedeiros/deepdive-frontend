import 'package:dio/dio.dart';
import '../model/SendAudioRequest.dart';
import '../model/SendAudioResponse.dart';

class SendAudioEndPoint {
  final Dio _dio;
  SendAudioEndPoint(this._dio);

  Future sendAudio(SendAudioRequest request) async {
    final headers = {
      'Authorization': request.token,
    };
    final data = {
      "transcription": request.transcription,
      "audio": request.audio,
    };
    try {
      var response = await _dio.post('/send/audio/${request.id}',
          data: data, options: Options(headers: headers));
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class SendAudioRepository {
  final SendAudioEndPoint sendAudioEndPoint;

  SendAudioRepository({required this.sendAudioEndPoint});

  Future sendAudio(SendAudioRequest request) async {
    final result = await sendAudioEndPoint.sendAudio(request);
    if (result.runtimeType == DioError) {
      return SendAudioResponse.fromJson(result.response.data);
    } else {
      return SendAudioResponse.fromJson(result);
    }
  }
}

class SendAudioUseCase {
  final SendAudioRepository repository;

  SendAudioUseCase({required this.repository});

  Future execute(SendAudioRequest request) async {
    final response = await repository.sendAudio(request);
    return response;
  }
}
