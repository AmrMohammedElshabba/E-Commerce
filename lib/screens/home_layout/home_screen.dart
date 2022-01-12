import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/componants/grid_product_view.dart';
import 'package:e_commerce/componants/show_toast.dart';
import 'package:e_commerce/models/caregories_model.dart';
import 'package:e_commerce/models/home_model.dart';
import 'package:e_commerce/screens/home_layout/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'cubit/home_states.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is PostFavoriteSuccessState) {
          if (!state.getFavoriteModel.state!) {
            ShowToast(state.getFavoriteModel.message!);
          }
        }
        if (state is AddOrRemoveSuccessState) {
          if (state.addOrRemoveCart.status!) {
            ShowToast(state.addOrRemoveCart.message!);
          }
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.getCategories != null,
          builder: (context) => BuildHomeProduct(
              cubit.homeModel!, cubit.getCategories!.data!, context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget BuildHomeProduct(HomeModel homeModel, CategoriesData categoriesData,
      BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            child: CarouselSlider(
              items: homeModel.data!.banners
                  .map((e) => Image(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage('${e.image}')))
                  .toList(),
              options: CarouselOptions(
                  initialPage: 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Categories',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Card(
                            child: Stack(
                              children: [
                                Image(
                                  image: NetworkImage(
                                      categoriesData.data[index].image!),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                    width: 100,
                                    color: Colors.black.withOpacity(.6),
                                    child: Text(
                                      categoriesData.data[index].name!,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color:Colors.white, overflow: TextOverflow.ellipsis),
                                      maxLines: 1,
                                    )),
                              ],
                              alignment: Alignment.bottomCenter,
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesData.data.length),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'New Products',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Container(
//            color: Colors.white,
            child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: .6,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                    homeModel.data!.products.length,
                    (index) => BuildGridProduct(
                        homeModel.data!.products[index], context))),
          )
        ],
      ),
    );
  }
}
