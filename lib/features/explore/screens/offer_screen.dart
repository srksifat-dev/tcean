import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcean/core/common/error_text.dart';
import 'package:tcean/core/common/loader.dart';
import 'package:tcean/features/explore/controller/offer_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/offer_section.dart';

class OfferScreen extends ConsumerWidget {
  const OfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offers"),
      ),
      body: ref.watch(getOffersProvider).when(
            data: (data) {
              return ListView.separated(
                itemBuilder: (context, index) => offerSection(
                    context: context, coupon: data[index], ref: ref),
                separatorBuilder: (_, __) => 16.heightBox,
                itemCount: data!.length,
              ).px(16);
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
      //  MasonryGridView.builder(
      //   itemCount: offer.productsID!.length,
      //   gridDelegate:
      //       SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      //   itemBuilder: (context, index) {
      //     ProductModel product = ref
      //         .read(productControllerProvider)
      //         .getProduct(offer.productsID![index]).first;
      //     return Card(
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(16),
      //       ),
      //       child: InkWell(
      //         onTap: () {
      //           context.pushNamed(RouteConst.kProductDetails,
      //               pathParameters: {"productID": product.productID});
      //         },
      //         child: Column(
      //           children: [
      //             Image.asset(
      //               product.productImageUrls.first,
      //             ),
      //             Divider(
      //               thickness: 2,
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 8.widthBox,
      //                 Expanded(
      //                   child: Text(product.productName,
      //                       style: Theme.of(context).textTheme.bodyMedium,
      //                       overflow: TextOverflow.ellipsis),
      //                 ),
      //                 IconButton(onPressed: () {}, icon: Icon(Icons.add))
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //     ).pSymmetric(h: 8, v: 8);
      //   },
      // ),
    );
  }
}
