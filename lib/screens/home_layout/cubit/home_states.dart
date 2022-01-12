import 'package:e_commerce/models/add_or_remove_cart_model.dart';
import 'package:e_commerce/models/change_pass_model.dart';
import 'package:e_commerce/models/user_data.dart';
import 'package:e_commerce/models/post_favorite_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ChangeBottomNavBar extends HomeStates {}

class ChangeAppMode extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {}

class HomeErrorState extends HomeStates {}

class CategoriesSuccessState extends HomeStates {}

class CategoriesErrorState extends HomeStates {}

class PostLoadingFavState extends HomeStates {}

class PostFavoriteSuccessState extends HomeStates {
  final PostFavoriteModel getFavoriteModel;

  PostFavoriteSuccessState(this.getFavoriteModel);
}

class PostFavoriteErrorState extends HomeStates {}

class GetLoadingFavState extends HomeStates {}

class GetFavoriteSuccessState extends HomeStates {}

class GetFavoriteErrorState extends HomeStates {}

class LoadingUserDataState extends HomeStates {}

class GetUserDataSuccessState extends HomeStates {}

class GetUserDataErrorState extends HomeStates {}

class LoadingPutUserDataState extends HomeStates {}

class PutUserDataSuccessState extends HomeStates {}

class PutUserDataErrorState extends HomeStates {}

class LogoutSuccessState extends HomeStates {}

class LogoutErrorState extends HomeStates {}

class LoginInitialState extends HomeStates {}

class ChangePasswordVisibilityState extends HomeStates {}

class LoadingLoginState extends HomeStates {}

class LoginSuccessState extends HomeStates {
  final User loginModel;
  LoginSuccessState({required this.loginModel});
}

class LoginErrorState extends HomeStates {
  final String error;
  LoginErrorState({required this.error});
}

class LoadingRegisterState extends HomeStates {}

class RegisterSuccessState extends HomeStates {
  final User loginModel;
  RegisterSuccessState({required this.loginModel});
}

class RegisterErrorState extends HomeStates {
  final String error;
  RegisterErrorState({required this.error});
}

class LoadingGetCartsState extends HomeStates {}

class GetCartsSuccessState extends HomeStates {}

class GetCartsErrorState extends HomeStates {}

class AddOrRemoveLoadingState extends HomeStates {}

class AddOrRemoveSuccessState extends HomeStates {
  final AddOrRemoveCart addOrRemoveCart;

  AddOrRemoveSuccessState(this.addOrRemoveCart);
}

class AddOrRemoveErrorState extends HomeStates {}

class LoadingChangePassState extends HomeStates {}

class ChangePassSuccessState extends HomeStates {
  ChangePasswordModel changePasswordModel;
  ChangePassSuccessState(this.changePasswordModel);
}

class ChangePassErrorState extends HomeStates {}
