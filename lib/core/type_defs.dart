import 'package:fpdart/fpdart.dart';
import 'package:tcean/core/failure.dart';
import 'package:tcean/models/user.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
