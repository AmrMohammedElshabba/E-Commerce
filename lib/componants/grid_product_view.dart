import 'package:e_commerce/screens/home_layout/cubit/home_cubit.dart';
import 'package:e_commerce/screens/home_layout/product_description.dart';
import 'package:flutter/material.dart';

import '../constans.dart';

Widget BuildGridProduct(
  productModel,
  BuildContext context,
) =>
    Card(
      shadowColor: Colors.black,
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDescription(productModel)));
            },
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(productModel.image!),
                  width: double.infinity,
                  height: 200,
                ),
                if (productModel.discount != 0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Discount',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productModel.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('Price ${productModel.price.round()}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: defaultColor)),
                    SizedBox(
                      width: 5,
                    ),
                    if (productModel.discount != 0)
                      Text('${productModel.oldPrice.round()}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          HomeCubit.get(context)
                              .ChangeFavorite(productModel.id!);
                        },
                        icon:
                            HomeCubit.get(context).isFavorite![productModel.id]!
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.redAccent,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: Colors.blue,
                                  )),
                    IconButton(
                        onPressed: () {
                          HomeCubit.get(context)
                              .AddOrRemoveToCart(productModel.id!);
                        },
                        icon: HomeCubit.get(context).inCart![productModel.id]!
                            ? const Icon(
                                Icons.remove_shopping_cart,
                                color: Colors.blue,
                              )
                            : const Icon(
                                Icons.shopping_cart,
                                color: Colors.blue,
                              )),
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
