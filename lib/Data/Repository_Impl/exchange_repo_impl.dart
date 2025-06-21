import 'package:dartz/dartz.dart';

import '../../Index/index.dart';

class ExchangeRepositoryImpl extends ExchangeRepository {
  late final ExchangeRemoteDataSourceRepo _exchangeRemoteDataSourceRepo;

  ExchangeRepositoryImpl(this._exchangeRemoteDataSourceRepo);

  @override
  Future<Either<AppError, ExchangeEntity>> getExchangeRateDomain(
    Map<String, dynamic> data,
  ) async {
    final result = await _exchangeRemoteDataSourceRepo.getExchangeRate(data);

    return result is Success<ExchangeModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message));
  }
}
