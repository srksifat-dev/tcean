// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tcean/core/common/main_appBar.dart';
// import 'package:velocity_x/velocity_x.dart';

// import '../../../dummy/dummy_product.dart';
// import '../../../core/constants/route_const.dart';

// class FavoritesScreen extends StatelessWidget {
//   const FavoritesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: mainAppBar(context: context,ref: r),
//       body: MasonryGridView.builder(
//         itemCount: dummyProducts.length,
//         gridDelegate:
//             SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (context, index) => Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: InkWell(
//             onTap: () {
//               context.pushNamed(RouteConst.kProductDetails, pathParameters: {
//                 "productID": dummyProducts[index].productID
//               });
//               // print(GoRouterState.of(context).fullPath);
//             },
//             child: Column(
//               children: [
//                 Image.asset(
//                   dummyProducts[index].productImageUrls.first,
//                 ),
//                 Divider(
//                   thickness: 2,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     8.widthBox,
//                     Expanded(
//                       child: Text(dummyProducts[index].productName,
//                           style: Theme.of(context).textTheme.bodyMedium,
//                           overflow: TextOverflow.ellipsis),
//                     ),
//                     IconButton(onPressed: () {}, icon: Icon(Icons.favorite))
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ).pSymmetric(h: 8, v: 8),
//       ).px(16),
//     );
//   }
// }
