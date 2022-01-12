class ChangePasswordModel {
  bool? status;
  String? message;



  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }


}