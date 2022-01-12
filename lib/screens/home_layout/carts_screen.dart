import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/componants/list_product_view.dart';
import 'package:e_commerce/models/get_favorite_model.dart';
import 'package:e_commerce/screens/home_layout/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constans.dart';
import 'cubit/home_cubit.dart';

class CartsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
            condition:
              cubit.getCarts != null,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => BuildListProduct(
                    cubit.getCarts!.data!.cartItems![index].product, context,isCart: true),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount:  cubit.getCarts!.data!.cartItems!.length),
            fallback: (context) =>  const Center(child: Text("Not Carts Yet",style: TextStyle(fontSize: 20,color: Colors.grey),)));
      },
    );
  }
}
