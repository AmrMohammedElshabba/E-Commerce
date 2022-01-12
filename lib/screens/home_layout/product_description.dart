import 'package:e_commerce/models/home_model.dart';
import 'package:flutter/material.dart';

import '../../constans.dart';

class ProductDescription extends StatelessWidget {
  final ProductModel productModel;
  ProductDescription(this.productModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Expanded(
                      child: Container(
                          height: 200,
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productModel.name!,
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20)),
                              Spacer(),
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
                                                decoration: TextDecoration
                                                    .lineThrough)),
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    child: Image(
                      image: NetworkImage(productModel.image!),
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(productModel.description!,
                        maxLines: 15,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
