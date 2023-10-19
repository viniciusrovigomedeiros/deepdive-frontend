import '../../shared/widgets/models/UserModel.dart';

class AuthUserResponse {
  String? status;
  dynamic result;
  String? token;

  AuthUserResponse({this.status, this.result, this.token});

  AuthUserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        status == 'error' ? json['result'] : UserModel.fromJson(json['result']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['token'] = token;
    return data;
  }
}
