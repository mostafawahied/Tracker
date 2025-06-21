import 'package:dartz/dartz.dart';

import '../../Index/index.dart';

class GetExchangeRateUseCase
    extends UseCaseOutput<Either<AppError, ExchangeEntity>, ExchangeParams> {
  final ExchangeRepository _exchangeRepositoryImpl;

  // Constructor
  GetExchangeRateUseCase(this._exchangeRepositoryImpl);

  @override
  Future<Either<AppError, ExchangeEntity>> call(
    ExchangeParams exchangeParams,
  ) async {
    if (kDebugMode) {
      print("Calling use case with: ${exchangeParams.toJson()}");
    } // ← add this

    return await _exchangeRepositoryImpl.getExchangeRateDomain(
      exchangeParams.toJson(),
    );
  }
}
