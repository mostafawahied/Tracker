import 'package:dartz/dartz.dart';

import '../../Index/index.dart';

abstract class ExchangeRepository {
  /// Fetch exchange rate
  Future<Either<AppError, ExchangeEntity>> getExchangeRateDomain(
    Map<String, dynamic> data,
  );
}
