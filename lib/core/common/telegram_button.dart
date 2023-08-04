import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class TelegramButton extends StatelessWidget {
  const TelegramButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          if (!await launchUrl(
            Uri.parse("https://t.me/tcean"),
            mode: LaunchMode.externalApplication,
          )) {
            throw Exception("can't launch for now");
          }
        },
        child:
            SvgPicture.asset("assets/images/telegramButton.svg"));
  }
}