import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppButton extends StatelessWidget {
  const WhatsAppButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          if (!await launchUrl(
            Uri.parse("https://wa.me/8801930132595"),
            mode: LaunchMode.externalApplication,
          )) {
            throw Exception("can't launch for now");
          }
        },
        child:
            SvgPicture.asset("assets/images/whatsAppButton.svg"));
  }
}