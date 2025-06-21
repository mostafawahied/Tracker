import '../../Index/index.dart';

abstract class ExchangeRemoteDataSourceRepo {
  Future<ApiResult<ExchangeModel>> getExchangeRate(Map<String, dynamic> data);
}
