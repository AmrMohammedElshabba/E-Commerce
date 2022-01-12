import 'package:bloc/bloc.dart';
import 'package:e_commerce/constans.dart';
import 'package:e_commerce/cubit/cubit_observer.dart';
import 'package:e_commerce/screens/home_layout/cubit/home_cubit.dart';
import 'package:e_commerce/screens/home_layout/cubit/home_states.dart';
import 'package:e_commerce/screens/home_layout/home_layout.dart';

import 'package:e_commerce/screens/login/login_screen.dart';
import 'package:e_commerce/screens/onboarding_screen.dart';
import 'package:e_commerce/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'network/cache_helper.dart';
import 'network/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget startWidget = OnBoarding();
  bool? onboarding = CacheHelper.getData(key: "onboarding");
  bool? darkMode = CacheHelper.getData(key: "lightMode");
  if(darkMode == null){
    darkMode = false;
  }
  token = CacheHelper.getData(key: "token");
  print(token);
  if (onboarding != null) {
    if (token != null)
      startWidget = HomeLayout();
    else
      startWidget = LoginPage();
  } else {
    startWidget = OnBoarding();
  }

  runApp(MyApp(
    startWidget: startWidget,
    darkMode: darkMode,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool darkMode;
  MyApp({required this.startWidget, required this.darkMode});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HomeCubit()
              ..GetHomeDate()
              ..GetCategoriesDate()
              ..GetFavDate()
              ..GetUserDate()
              ..GetCart()
              ..changeAppMode(fromShare: darkMode)),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: cubit.darkMode ? ThemeMode.dark : ThemeMode.light,
            theme: LightTheme(),
            darkTheme: darkTheme(),
            home: startWidget,
          );
        },
      ),
    );
  }
}
