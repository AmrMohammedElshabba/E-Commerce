import 'package:bloc/bloc.dart';
import 'package:e_commerce/models/search_model.dart';
import 'package:e_commerce/network/dio_helper.dart';
import 'package:e_commerce/screens/home_layout/cubit/search_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constans.dart';
import '../../../end_point.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void Search(
    String text,
  ) {
    emit(LoadingSearchState());
    DioHelper.PostData(
        url: search,
        lang: "en",
        token: token,
        data: {'text': text}).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.data!.data![0].name!);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
