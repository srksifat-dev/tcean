import 'package:flutter/material.dart';
import 'package:tcean/dummy/dummy_product.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int deliveryCharge = 60;
  int total = 60;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  var cart = Dummy.carts[index];
                  return Dismissible(
                    key: ValueKey(Dummy.carts[index].product.productID),
                    background: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      color: Theme.of(context).colorScheme.error,
                    ),
                    onDismissed: (_) {
                      setState(() {
                        Dummy.carts.remove(Dummy.carts[index]);
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            Dummy.carts[index].product.productImageUrls.first,
                            height: 100,
                          ),
                          8.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Dummy.carts[index].product.productName,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Text(
                                  "Color: ${cart.color}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  "Size: ${cart.size}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.remove)),
                              Text(
                                "${cart.quantity.toString()}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.add))
                            ],
                          )
                        ],
                      ).pOnly(
                        left: 16,
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => 16.heightBox,
                itemCount: Dummy.carts.length),
          ),
          AnimatedContainer(
            height: Dummy.carts.isEmpty ? 0 : 70,
            width: context.percentWidth * 100,
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.onBackground),
            child: Visibility(
              maintainAnimation: true,
              visible: Dummy.carts.isEmpty ? false : true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Delivery Charge: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                            ),
                            Text(
                              deliveryCharge.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Total: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                            ),
                            Text(
                              total.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FilledButton(onPressed: () {}, child: Text("Check Out"))
                ],
              ).px(16),
            ),
          ),
        ],
      ).px(16),
    );
  }
}
