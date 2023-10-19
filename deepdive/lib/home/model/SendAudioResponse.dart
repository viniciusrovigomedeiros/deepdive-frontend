class SendAudioResponse {
  String? status;
  Result? result;

  SendAudioResponse({this.status, this.result});

  SendAudioResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  String? message;
  String? transcription;
  String? audioBase64;

  Result({this.message, this.transcription, this.audioBase64});

  Result.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    transcription = json['transcription'];
    audioBase64 = json['audioBase64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['transcription'] = transcription;
    data['audioBase64'] = audioBase64;
    return data;
  }
}
