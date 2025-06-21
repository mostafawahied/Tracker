// expenses_bloc.dart
import '../../../Index/index.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  static const int _pageSize = 10;

  late Box<Expense> _box;
  List<Expense> _all = [];
  int _currentIndex = 0;

  ExpensesBloc() : super(ExpensesInitial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<LoadThisMonthExpenses>(_onLoadThisMonthExpenses);
    on<LoadLast7DaysExpenses>(_onLoadLast7DaysExpenses);
    _init();
  }

  Future<void> _init() async {
    _box = await Hive.openBox<Expense>('expenses');
    _all = _box.values
        .toList()
        .reversed
        .toList(); // reverse to show recent first
    add(LoadExpenses(isInitial: true));
  }

  void _onLoadExpenses(LoadExpenses event, Emitter<ExpensesState> emit) {
    if (event.isInitial) {
      _currentIndex = 0;

      // 🆕 Re-fetch latest data from Hive
      _all = _box.values.toList().reversed.toList();
    }

    final nextItems = _all.skip(_currentIndex).take(_pageSize).toList();
    _currentIndex += nextItems.length;

    final isLastPage = _currentIndex >= _all.length;

    final currentList = event.isInitial
        ? nextItems
        : (state is ExpensesLoaded
              ? (state as ExpensesLoaded).expenses + nextItems
              : nextItems);

    emit(ExpensesLoaded(currentList, hasMore: !isLastPage));
  }

  void _onLoadThisMonthExpenses(
    LoadThisMonthExpenses event,
    Emitter<ExpensesState> emit,
  ) {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);

    final filtered = _box.values
        .where(
          (e) =>
              e.date.isAfter(startOfMonth) ||
              e.date.isAtSameMomentAs(startOfMonth),
        )
        .toList()
        .reversed
        .toList();

    emit(ExpensesLoaded(filtered, hasMore: false));
  }

  void _onLoadLast7DaysExpenses(
    LoadLast7DaysExpenses event,
    Emitter<ExpensesState> emit,
  ) {
    final now = DateTime.now();
    final last7 = now.subtract(Duration(days: 7));

    final filtered = _box.values
        .where((e) => e.date.isAfter(last7))
        .toList()
        .reversed
        .toList();

    emit(ExpensesLoaded(filtered, hasMore: false));
  }
}
