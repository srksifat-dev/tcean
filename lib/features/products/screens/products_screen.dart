import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/core/common/main_appBar.dart';
import 'package:tcean/dummy/dummy_category.dart';
import 'package:tcean/models/product_model.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../core/constants/route_const.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductsScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<ProductsScreen> {
  int selectedCategory = 0;
  List<bool> selectedCategories = [];

  bool _isBackPressed = false;

  Future<bool> _onWillPop() async {
    if (_isBackPressed) {
      // If already pressed once, exit the app
      return true;
    }

    _isBackPressed = true;
    _showSnackBar('Press back again to exit');

    Timer(const Duration(seconds: 2), () {
      // Reset the flag after 2 seconds
      _isBackPressed = false;
    });

    return false;
  }

  void _showSnackBar(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < dummyCategories.length; i++) {
      selectedCategories.add(false);
    }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: mainAppBar(context: context,ref: ref),
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
              child: MasonryGridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    onTap: () {
                      context.pushNamed(RouteConst.kProductDetails,
                          pathParameters: {
                            "productID": products[index].productID
                          },
                          extra: products[index]);
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            key: UniqueKey(),
                            imageUrl: products[index].productImageUrls.first,
                            placeholder: (context, url) => const Text("tcean.store"),
                            errorWidget: (context, url, error) =>
                                const Text("tcean.store"),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            8.widthBox,
                            Expanded(
                              child: Text(products[index].productName,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ).pSymmetric(h: 8, v: 8),
              ),
            ),
          ],
        ).px(16),
      ),
    );
  }
}
