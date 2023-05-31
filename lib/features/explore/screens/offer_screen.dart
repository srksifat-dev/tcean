import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/dummy/dummy_offer.dart';
import 'package:tcean/dummy/dummy_product.dart';
import 'package:tcean/models/offer.dart';
import 'package:tcean/models/product.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../routes/route_const.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({Key? key, required this.offerID}) : super(key: key);
  final String offerID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dummy_offer.title),
      ),
      body: MasonryGridView.builder(
        itemCount: dummy_offer.productsID!.length,
        gridDelegate:
            SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          Product product = Dummy.products
              .where(
                (element) => element.productID == dummy_offer.productsID![index],
              )
              .first;
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () {
                context.pushNamed(RouteConst.kProductDetails,
                    pathParameters: {"productID": product.productID});
              },
              child: Column(
                children: [
                  Image.asset(
                    product.productImageUrls.first,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      8.widthBox,
                      Expanded(
                        child: Text(product.productName,
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.add))
                    ],
                  )
                ],
              ),
            ),
          ).pSymmetric(h: 8, v: 8);
        },
      ),
    );
  }
}
