import 'package:dartz/dartz.dart';

import '../../Index/index.dart';

abstract class UseCase<OutPut, InPut> {
  Future<Either<AppError, OutPut>> call(InPut input);
}

abstract class UseCaseOutput<OutPut, InPut> {
  Future<OutPut> call(InPut input);
}
