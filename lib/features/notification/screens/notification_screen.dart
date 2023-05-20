import 'package:flutter/material.dart';
import 'package:tcean/dummy/dummy_notification.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
        ),
      ),
      body: ListView.separated(
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dummy_notification[index].title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        dummy_notification[index].body,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ).p(16),
                );
              },
              separatorBuilder: (_, __) => 8.heightBox,
              itemCount: dummy_notification.length)
          .px(16),
    );
  }
}
