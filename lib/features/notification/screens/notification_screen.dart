import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tcean/core/common/error_text.dart';
import 'package:tcean/core/common/loader.dart';
import 'package:tcean/features/notification/controller/notification_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
        ),
      ),
      body: ref.watch(getNotificationsProvider).when(
            data: (notifications) => notifications.isEmpty
                ? Center(
                    child: Lottie.asset("assets/lotties/no_notification.json"))
                : ListView.separated(
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notifications[index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      notifications[index].body,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ).p(16),
                              ),
                              Text(
                                notifications[index].dateTime,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 10),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (_, __) => 8.heightBox,
                        itemCount: notifications.length)
                    .px(16),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
