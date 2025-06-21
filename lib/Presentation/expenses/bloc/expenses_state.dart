import 'package:equatable/equatable.dart';

import '../../../Data/Models/expense.dart';

abstract class ExpensesState extends Equatable {
  const ExpensesState();

  @override
  List<Object?> get props => [];
}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoading extends ExpensesState {}

class ExpensesLoaded extends ExpensesState {
  final List<Expense> expenses;
  final bool hasMore;
  final double totalAmount;

  ExpensesLoaded(this.expenses, {required this.hasMore})
    : totalAmount = expenses.fold(0, (sum, e) => sum + e.amount);

  @override
  List<Object?> get props => [expenses, hasMore, totalAmount];
}

class ExpensesError extends ExpensesState {
  final String message;

  const ExpensesError(this.message);

  @override
  List<Object?> get props => [message];
}
