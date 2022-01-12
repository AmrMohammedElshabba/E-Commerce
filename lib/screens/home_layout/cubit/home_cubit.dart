import 'package:e_commerce/constans.dart';
import 'package:e_commerce/models/add_or_remove_cart_model.dart';
import 'package:e_commerce/models/caregories_model.dart';
import 'package:e_commerce/models/change_pass_model.dart';
import 'package:e_commerce/models/get_carts_model.dart';

import 'package:e_commerce/models/get_favorite_model.dart';
import 'package:e_commerce/models/user_data.dart';
import 'package:e_commerce/models/post_favorite_model.dart';
import 'package:e_commerce/models/home_model.dart';
import 'package:e_commerce/network/cache_helper.dart';
import 'package:e_commerce/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constans.dart';
import '../../../end_point.dart';
import '../carts_screen.dart';
import '../favorites_screen.dart';
import '../home_screen.dart';
import 'package:e_commerce/screens/home_layout/setting/settings_screen.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  bool darkMode = false;
  void changeAppMode({bool? fromShare}){
    if(fromShare!= null){
      darkMode = fromShare;
    }
    else darkMode = !darkMode;
    CacheHelper.saveData(key: "lightMode", value: darkMode).then((value) {
      emit(ChangeAppMode());
    });

  }


  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Carts"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];
  List<Widget> screens = [
    HomePage(),
    CartsPage(),
    FavoritesPage(),
    SettingPage(),
  ];

  void ChangeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBar());
  }

  Map<int, bool>? isFavorite = {};
  Map<int, bool>? inCart = {};
  PostFavoriteModel? postFavoriteModel;
  User? loginModel;

  void ChangeFavorite(int productId) {
    isFavorite![productId] = !isFavorite![productId]!;
    emit(PostLoadingFavState());

    DioHelper.PostData(
      url: Favorites,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      postFavoriteModel = PostFavoriteModel.fromJson(value.data);
      if (postFavoriteModel!.state!) {
        GetFavDate();
        print(postFavoriteModel!.state);
      } else {
        isFavorite![productId] = !isFavorite![productId]!;
      }
      emit(PostFavoriteSuccessState(postFavoriteModel!));
    }).catchError((error) {
      print(error.toString());
      isFavorite![productId] = !isFavorite![productId]!;
      emit(PostFavoriteErrorState());
    });
  }

  HomeModel? homeModel;
  void GetHomeDate() {
    emit(HomeLoadingState());
    DioHelper.getData(url: Home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.data!.products[0].name);
      homeModel!.data!.products.forEach((element) {
        isFavorite!.addAll({element.id!: element.inFavorites!});
        inCart!.addAll({element.id!: element.inCart!});
      });
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState());
    });
  }

  GetFavoriteModel? getFavoriteModel;
  void GetFavDate() {
    emit(GetLoadingFavState());
    DioHelper.getData(url: Favorites, token: token).then((value) {
      getFavoriteModel = GetFavoriteModel.fromJson(value.data);
      print(getFavoriteModel!.data!.data![1].product!.name);
      emit(GetFavoriteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoriteErrorState());
    });
  }

  GetCategories? getCategories;
  void GetCategoriesDate() {
    DioHelper.getData(url: Categories).then((value) {
      getCategories = GetCategories.fromJson(value.data);
      print(getCategories!.data!.data[1].name);
      emit(CategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoriesErrorState());
    });
  }

  GetCartsModel? getCarts;
  void GetCart() {
    emit(LoadingGetCartsState());
    DioHelper.getData(url: Carts, token: token).then((value) {
      getCarts = GetCartsModel.fromJson(value.data);
      emit(GetCartsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCartsErrorState());
    });
  }

  AddOrRemoveCart? addOrRemoveCart;

  void AddOrRemoveToCart(productId) {
    inCart![productId] = !inCart![productId]!;

    emit(AddOrRemoveLoadingState());

    DioHelper.PostData(
      url: Carts,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      addOrRemoveCart = AddOrRemoveCart.fromJson(value.data);
      if (addOrRemoveCart!.status!) {
        GetCart();
        print(addOrRemoveCart!.status!);
      } else {
        inCart![productId] = !inCart![productId]!;
      }
      emit(AddOrRemoveSuccessState(addOrRemoveCart!));
    }).catchError((error) {
      inCart![productId] = !inCart![productId]!;

      print(error.toString());
      emit(AddOrRemoveErrorState());
    });
  }

  void GetUserDate() {
    emit(LoadingUserDataState());
    DioHelper.getData(url: Profile, token: token).then((value) {
      loginModel = User.fromJson(value.data);
      print(loginModel!.data!.name);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState());
    });
  }

  void PutUserDate(
      {required String name, required String email, required String phone}) {
    emit(LoadingPutUserDataState());
    DioHelper.PutData(url: UpdateProfile, token: token, data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      loginModel = User.fromJson(value.data);
      print(loginModel!.data!.name);
      emit(PutUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PutUserDataErrorState());
    });
  }

  void Logout() {
    DioHelper.PostData(
      url: logout,
      data: {"fcm_token": "SomeFcmToken"},
      token: token,
    ).then((value) {
      emit(LogoutSuccessState());
    }).catchError((error) {
      emit(LogoutErrorState());
    });
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_off_outlined;
  void ShowPassword() {
    isPassword = !isPassword;
    if (isPassword) {
      suffixIcon = Icons.visibility_off_outlined;
    } else {
      suffixIcon = Icons.visibility_outlined;
    }
    emit(ChangePasswordVisibilityState());
  }

  void UserLogin({required String email, required String password}) {
    emit(LoadingLoginState());
    DioHelper.PostData(url: Login, data: {
      "email": email,
      "password": password,
    }).then((value) {

      loginModel = User.fromJson(value.data);
      token = loginModel!.data!.token!;
      GetHomeDate();
      GetUserDate();
      GetFavDate();
      GetCategoriesDate();
      GetCart();
      print(token);
      emit(LoginSuccessState(loginModel: loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error: error.toString()));
    });
  }

  void UserRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(LoadingRegisterState());
    DioHelper.PostData(url: Register, data: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    }).then((value) {
      loginModel = User.fromJson(value.data);
      token = loginModel!.data!.token!;
      GetHomeDate();
      GetUserDate();
      GetFavDate();
      GetCategoriesDate();
      GetCart();
      print(token);
      emit(RegisterSuccessState(loginModel: loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error: error.toString()));
    });
  }

  ChangePasswordModel? changePasswordModel;
  void ChangePassword(
      {required String currentPass, required String newpassword}) {
    emit(LoadingChangePassState());
    DioHelper.PostData(
      url: changepassword,
      data: {"current_password": currentPass, "new_password": newpassword},
      token: token,
    ).then((value) {
      changePasswordModel = ChangePasswordModel.fromJson(value.data);
      emit(ChangePassSuccessState(changePasswordModel!));
    }).catchError((error) {
      emit(ChangePassErrorState());
    });
  }
}
