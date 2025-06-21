import '../../../Index/index.dart';

abstract class AddExpenseEvent extends Equatable {
  const AddExpenseEvent();
}

class GetExchangeRateEvent extends AddExpenseEvent {
  final ExchangeParams params;

  const GetExchangeRateEvent(this.params);

  @override
  List<Object> get props => [params];
}

class ResetExpense extends AddExpenseEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
