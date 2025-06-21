import 'package:tracker/Index/index.dart';

abstract class AddExpenseState extends Equatable {
  const AddExpenseState();

  @override
  List<Object?> get props => [];
}

class ExchangeInitial extends AddExpenseState {}

class ExchangeLoading extends AddExpenseState {}

class ExchangeLoaded extends AddExpenseState {
  final ExchangeEntity exchange;

  const ExchangeLoaded(this.exchange);

  @override
  List<Object?> get props => [exchange];
}

class ExchangeError extends AddExpenseState {
  final String message;

  const ExchangeError(this.message);

  @override
  List<Object?> get props => [message];
}
