import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/componants/grid_product_view.dart';
import 'package:e_commerce/componants/list_product_view.dart';
import 'package:e_commerce/componants/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_cubit.dart';
import 'cubit/home_states.dart';
import 'cubit/search_cubit.dart';
import 'cubit/search_states.dart';

class SearchPage extends StatelessWidget {
  var SearchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SearchCubit.get(context);
            return Scaffold(
              body: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: defaultFormField(
                          prefix: Icons.search,
                          lable: "Search",
                          keybordType: TextInputType.text,
                          validateText: "Search pls",
                          controller: SearchController,
                          onSubmitted: (String text) {
                            cubit.Search(text);
                          }),
                    ),
                    if (state is LoadingSearchState) LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                              itemBuilder: (context, index) => BuildListProduct(
                                  cubit.searchModel!.data!.data![index],
                                  context, showDiscount: false
                                ),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 10,
                                  ),
                              itemCount: cubit.searchModel!.data!.data!.length),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
