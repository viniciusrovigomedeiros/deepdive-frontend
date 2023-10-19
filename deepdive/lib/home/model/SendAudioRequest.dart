class SendAudioRequest {
  String transcription;
  String audio;
  String id;
  String token;

  SendAudioRequest({
    required this.transcription,
    required this.audio,
    required this.id,
    required this.token,
  });
}
