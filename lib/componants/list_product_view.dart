import 'package:e_commerce/screens/home_layout/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

import '../constans.dart';

Widget BuildListProduct(product, context,
        {bool isCart = false, showDiscount = true}) =>
    Card(
      child: Container(
        height: 150,
        width: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(product.image!),
                  width: 150,
                  height: 150,
                ),
                if (product.discount != 0 && showDiscount)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('Discount',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white)),
                    ),
                  )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(product.name!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1),
                    Spacer(),
                    Row(
                      children: [
                        Text(product.price.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: defaultColor)),
                        SizedBox(
                          width: 5,
                        ),
                        if (product.discount != 0 && showDiscount)
                          Text('${product.oldPrice.round()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough)),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              HomeCubit.get(context)
                                  .ChangeFavorite(product.id!);
                            },
                            icon:
                                HomeCubit.get(context).isFavorite![product.id]!
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: Colors.blue,
                                      )),
                        if (isCart)
                          IconButton(
                              onPressed: () {
                                HomeCubit.get(context)
                                    .AddOrRemoveToCart(product.id!);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
