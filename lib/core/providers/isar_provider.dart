// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:tcean/models/notification_model.dart';

// import '../../models/cart_model.dart';

// final isarProvider = FutureProvider<Isar>((ref) async{
//   final dir = await getApplicationDocumentsDirectory();
//     if (Isar.instanceNames.isEmpty) {
//       return await Isar.open(
//         [CartModelSchema,NotificationModelSchema],
//         directory: dir.path,
//         inspector: true,
//       );
//     }

//     return Future.value(Isar.getInstance());
// });