class AddOrRemoveCart {
  bool? status;
  String? message;



  AddOrRemoveCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }


}
