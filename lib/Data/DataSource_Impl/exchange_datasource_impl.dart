import '../../Index/index.dart';

class ExchangeDataSourceImpl extends ExchangeRemoteDataSourceRepo {
  late final ClientSourceRepo _clientSourceRepo;

  ExchangeDataSourceImpl(ClientSourceRepo client) {
    _clientSourceRepo = client;
  }

  @override
  Future<ApiResult<ExchangeModel>> getExchangeRate(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSourceRepo.request(
        HttpMethod.GET,
        ApiConstants.pairRates,
        params: data,
      );
      final exchangeRate = ExchangeModel.fromJson(response);
      return Success(exchangeRate);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }
}
