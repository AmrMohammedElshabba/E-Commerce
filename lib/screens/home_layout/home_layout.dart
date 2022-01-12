import 'package:e_commerce/network/cache_helper.dart';
import 'package:e_commerce/screens/home_layout/search_screen.dart';
import 'package:e_commerce/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constans.dart';
import '../onboarding_screen.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_states.dart';


class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = HomeCubit.get(context);
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavItems,
            onTap: (index){
              cubit.ChangeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
          ),
          appBar: AppBar(
            title: Text("E-Commerce"),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchPage()));
              }, icon: Icon(Icons.search)),

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
        );

      },
    );
  }
}

