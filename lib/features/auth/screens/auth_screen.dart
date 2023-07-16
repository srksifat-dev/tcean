import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:tcean/core/providers/firebase_providers.dart';
import 'package:tcean/features/auth/controller/auth_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/lotties/auth.json",
            width: context.percentWidth * 50,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Just one touch ahead to get in ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextSpan(
                  text: "tcean",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Color(0xff2F7FED),
                      ),
                ),
              ],
            ),
          ),
          64.heightBox,
          InkWell(
            onTap: () => signInWithGoogle(context, ref),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: isLoading ? Center(child: CircularProgressIndicator()) : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.google,
                    size: 32,
                  ),
                  8.widthBox,
                  Text("Sign in with Google"),
                ],
              ).p(16),
            ),
          ),
        ],
      ).px(16),
    );
  }
}
