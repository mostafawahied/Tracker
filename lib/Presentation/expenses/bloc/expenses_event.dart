import 'package:equatable/equatable.dart';

import '../../../Data/Models/expense.dart';

abstract class ExpensesEvent extends Equatable {
  const ExpensesEvent();

  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpensesEvent {
  final bool isInitial;

  const LoadExpenses({this.isInitial = false});
}

class AddExpense extends ExpensesEvent {
  final Expense expense;

  const AddExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}

class DeleteExpense extends ExpensesEvent {
  final int index;

  const DeleteExpense(this.index);

  @override
  List<Object?> get props => [index];
}

class LoadThisMonthExpenses extends ExpensesEvent {}

class LoadLast7DaysExpenses extends ExpensesEvent {}
