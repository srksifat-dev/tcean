import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../dummy/dummy_product.dart';
import '../../../routes/route_const.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasonryGridView.builder(
        itemCount: Dummy.products.length,
        gridDelegate:
            SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: () {
              context.pushNamed(RouteConst.kProductDetails, pathParameters: {
                "productID": Dummy.products[index].productID
              });
              print(GoRouterState.of(context).fullPath);
            },
            child: Column(
              children: [
                Image.asset(
                  Dummy.products[index].productImageUrls.first,
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    8.widthBox,
                    Expanded(
                      child: Text(Dummy.products[index].productName,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.favorite))
                  ],
                )
              ],
            ),
          ),
        ).pSymmetric(h: 8, v: 8),
      ).px(16),
    );
  }
}
