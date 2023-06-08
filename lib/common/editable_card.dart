import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget editableCard(
    {required BuildContext context,
    String? title,
    Widget? subtitle,
    required IconData icon,
    required void Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title.isEmptyOrNull
                  ? Container()
                  : Text(
                      title!,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
              subtitle ?? Container()
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
