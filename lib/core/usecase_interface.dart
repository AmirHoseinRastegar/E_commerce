import 'package:fpdart/fpdart.dart';

import 'failure.dart';

abstract interface class UseCase<successType, params> {
  Future<Either<Failure, successType>> call(params params);
}
