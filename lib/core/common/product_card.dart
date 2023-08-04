import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class productCard extends StatelessWidget {
  const productCard({
    required this.imageURL,
    required this.productName,
    super.key,
  });

  final String imageURL;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                key: UniqueKey(),
                imageUrl: imageURL,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Text("tcean.store"),
                errorWidget: (context, url, error) => const Text("tcean.store"),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                8.widthBox,
                Expanded(
                  child: Text(productName,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis),
                ),
                // IconButton(onPressed: () {}, icon: Icon(Icons.add))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
