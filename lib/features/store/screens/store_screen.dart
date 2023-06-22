import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/dummy/dummy_category.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../dummy/dummy_product.dart';
import '../../../routes/route_const.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int selectedCategory = 0;
  List<bool> selectedCategories = [];
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < dummyCategories.length; i++) {
      selectedCategories.add(false);
    }
    return Scaffold(
      body: Column(
        children: [
          //TODO: Category Section
          SizedBox(
            height: 50,
            width: context.percentWidth * 100,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => FilterChip(
                    label: Text(dummyCategories[index].label),
                    selected: selectedCategories[index],
                    onSelected: (val) {
                      setState(() {
                        selectedCategories[index] = val;
                      });
                    }),
                separatorBuilder: (_, __) => 16.widthBox,
                itemCount: selectedCategories.length),
          ),
          Expanded(
            child: MasonryGridView.builder(
              itemCount: Dummy.products.length,
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  onTap: () {
                    context.pushNamed(RouteConst.kProductDetails,
                        pathParameters: {
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
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border))
                        ],
                      )
                    ],
                  ),
                ),
              ).pSymmetric(h: 8, v: 8),
            ),
          )
        ],
      ).px(16),
    );
  }
}
