import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/componants/list_product_view.dart';
import 'package:e_commerce/models/get_favorite_model.dart';
import 'package:e_commerce/screens/home_layout/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constans.dart';
import 'cubit/home_cubit.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
            condition:
                state is! GetLoadingFavState && cubit.getFavoriteModel != null,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => BuildListProduct(
                    cubit.getFavoriteModel!.data!.data![index].product!, context),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: cubit.getFavoriteModel!.data!.data!.length),
            fallback: (context) => ConditionalBuilder(
                condition: cubit.getFavoriteModel != null,
                builder: (context) => const CircularProgressIndicator(),
                fallback: (context) => const Center(child: Text("Not Favorites Yet",style: TextStyle(fontSize: 20,color: Colors.grey),))));
      },
    );
  }
}
