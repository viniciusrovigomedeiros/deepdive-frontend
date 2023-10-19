import '../../shared/widgets/models/UserModel.dart';

class AuthUserResponse {
  String? status;
  UserModel? result;
  String? description;
  String? token;

  AuthUserResponse({this.status, this.result, this.description, this.token});

  AuthUserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'] != null ? UserModel.fromJson(json['result']) : null;
    description = json['description'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['description'] = description;
    data['token'] = token;
    return data;
  }
}
