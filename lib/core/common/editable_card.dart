import 'package:flutter/material.dart';

Widget editableCard(
    {required BuildContext context,
    String? sectionTitle,
    TextStyle? sectionTileTextStyle,
    Widget? title,
    Widget? subtitle,
    Widget? trailing,
    IconData? additionalButtonIcon,
    String? additionalButtonLabel,
    void Function()? onTap}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle != null
          ? Text(
              sectionTitle,
              style: sectionTileTextStyle ?? Theme.of(context).textTheme.bodySmall,
            )
          : Container(),
      Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            ListTile(
              title: title,
              trailing: trailing,
              subtitle: subtitle,
            ),
           additionalButtonIcon != null ? TextButton.icon(onPressed: onTap, icon: Icon(additionalButtonIcon), label:Text( additionalButtonLabel!),) : Container()
          ],
        ),
      ),
    ],
  );
}
