import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget accountCard(
    {required BuildContext context,
    required String title,
    String? subtitle,
    required IconData icon,
    required void Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              subtitle.isEmptyOrNull
                  ? Container()
                  : Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
            ],
          )),
          Icon(
            icon,
          )
        ],
      ).p(
        16,
      ),
    ),
  );
}
