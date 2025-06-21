import 'package:tracker/Index/index.dart';

final getIt = GetIt.instance;

void initServices() {
  final ClientSourceRepo client = getIt.registerSingleton(ClientSourceRepo());

  final ExchangeRemoteDataSourceRepo exchangeDataSourceImpl = getIt
      .registerSingleton(ExchangeDataSourceImpl(client));

  final ExchangeRepository quoteRepositoryImpl = getIt.registerSingleton(
    ExchangeRepositoryImpl(exchangeDataSourceImpl),
  );

  final GetExchangeRateUseCase pairUsecase = getIt.registerSingleton(
    GetExchangeRateUseCase(quoteRepositoryImpl),
  );

  getIt.registerFactory(
    () => AddExpenseBloc(getExchangeRateUseCase: pairUsecase),
  );
  getIt.registerFactory(() => ExpensesBloc());
}
