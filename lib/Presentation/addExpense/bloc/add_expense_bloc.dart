import '../../../Index/index.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final GetExchangeRateUseCase getExchangeRateUseCase;

  AddExpenseBloc({required this.getExchangeRateUseCase})
    : super(ExchangeInitial()) {
    on<ResetExpense>((event, emit) {
      emit(ExchangeInitial());
    });
    on<GetExchangeRateEvent>(_onGetExchangeRateEvent);
  }

  Future<void> _onGetExchangeRateEvent(
    GetExchangeRateEvent event,
    Emitter<AddExpenseState> emit,
  ) async {
    emit(ExchangeLoading());

    final result = await getExchangeRateUseCase(event.params);

    result.fold(
      (error) {
        if (kDebugMode) {
          print("Error: ${error.result}");
        }
        emit(ExchangeError(error.result));
      },
      (exchange) {
        if (kDebugMode) {
          print("Success: $exchange");
        }
        emit(ExchangeLoaded(exchange));
      },
    );
  }
}
