import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/core/common/error_text.dart';
import 'package:tcean/core/common/loader.dart';
import 'package:tcean/core/common/main_appBar.dart';
import 'package:tcean/dummy/dummy_category.dart';
import 'package:tcean/features/products/controller/products_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../core/constants/route_const.dart';

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> {
  int selectedCategory = 0;
  List<bool> selectedCategories = [];
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < dummyCategories.length; i++) {
      selectedCategories.add(false);
    }
    return Scaffold(
      appBar: mainAppBar(context: context),
      body: Column(
        children: [
          // //TODO: Category Section
          // SizedBox(
          //   height: 50,
          //   width: context.percentWidth * 100,
          //   child: ListView.separated(
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (context, index) => FilterChip(
          //           label: Text(dummyCategories[index].label),
          //           selected: selectedCategories[index],
          //           onSelected: (val) {
          //             setState(() {
          //               selectedCategories[index] = val;
          //             });
          //           }),
          //       separatorBuilder: (_, __) => 16.widthBox,
          //       itemCount: selectedCategories.length),
          // ),

          // TODO: Product Section
          Expanded(
              child: ref.watch(getProductsProvider).when(
                  data: (data) => MasonryGridView.builder(
                        itemCount: data.length,
                        gridDelegate:
                            SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) => Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: InkWell(
                            onTap: () {
                              context.pushNamed(RouteConst.kProductDetails,
                                  pathParameters: {
                                    "productID": data[index].productID
                                  });
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    key: UniqueKey(),
                                    imageUrl:
                                        data[index].productImageUrls.first,
                                    placeholder: (context, url) =>
                                        Text("tcean.store"),
                                    errorWidget: (context, url, error) =>
                                        Text("tcean.store"),
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    8.widthBox,
                                    Expanded(
                                      child: Text(data[index].productName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          overflow: TextOverflow.ellipsis),
                                    ),

                                    // TODO: Fuction to save as favorite product
                                    // IconButton(
                                    //     onPressed: () {},
                                    //     icon: Icon(Icons.favorite_border))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ).pSymmetric(h: 8, v: 8),
                      ),
                  error: (error, _) => ErrorText(error: error.toString()),
                  loading: () => Loader()))
        ],
      ).px(16),
    );
  }
}
