class PostFavoriteModel{
   bool? state;
   String? message;
  PostFavoriteModel.fromJson(Map<String ,dynamic> json){
    state = json['status'];
    message = json['message'];
  }

}