import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/route_const.dart';

AppBar mainAppBar({required BuildContext context}) {
  return AppBar(
    centerTitle: true,
    title: Row(
      children: [
        SvgPicture.asset("assets/images/tcean.svg",height: 30,),
        4.widthBox,
        Text(
          "tce",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        RotatedBox(
          quarterTurns: 2,
          child: Text(
            "e",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Text(
          "n",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    ),
    actions: [
      IconButton(
          onPressed: () {
            context.pushNamed(RouteConst.kNotifications);
          },
          icon: const Badge(child: Icon(Icons.notifications)))
    ],
  );
}
