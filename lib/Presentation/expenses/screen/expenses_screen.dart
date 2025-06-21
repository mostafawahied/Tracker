import 'package:tracker/Index/index.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  String selectedDate = 'This month';
  final ScrollController _scrollController = ScrollController();
  final List<int> _items = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _pageSize = 10;
  final int _maxPages = 5;

  @override
  void initState() {
    super.initState();

    _fetchMoreItems();

    _scrollController.addListener(() {
      // If close to bottom and not already loading
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _currentPage <= _maxPages) {
        _fetchMoreItems();
      }
    });
  }

  Future<void> _fetchMoreItems() async {
    setState(() => _isLoading = true);

    // Simulate delay like a network request
    await Future.delayed(Duration(seconds: 1));

    final newItems = List.generate(_pageSize, (i) => (_items.length + i + 1));

    setState(() {
      _items.addAll(newItems);
      _currentPage++;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<ExpensesBloc, ExpensesState>(
        builder: (context, state) {
          List<Expense> allExpenses = [];
          String total = "";
          if (state is ExpensesLoaded) {
            allExpenses = state.expenses;
            total = "\$${state.totalAmount}";
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                delegate: DashboardSliverWidget(
                  expandedHeight: 600.h,
                  totalExpenses: total,
                  selectedDate: selectedDate,
                  onChanged: (value) {
                    setState(() => selectedDate = value!);
                    final bloc = context.read<ExpensesBloc>();

                    if (value == 'all') {
                      bloc.add(LoadExpenses(isInitial: true));
                    } else if (value == 'month') {
                      bloc.add(LoadThisMonthExpenses());
                    } else if (value == 'week') {
                      bloc.add(LoadLast7DaysExpenses());
                    }
                  },
                ),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(60.h),
                  child: Container(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h),
                  child: Text(
                    'Recent Expenses',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              if (state is ExpensesLoading) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ] else if (allExpenses.isEmpty) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 60.h,
                    ),
                    child: Center(
                      child: Lottie.asset(
                        'assets/animation/Animation - 1750527560023.json',
                        repeat: true,
                        animate: true,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final expenses = (state).expenses;

                      if (index < expenses.length) {
                        final expense = expenses[index];
                        return ItemExpenseCard(
                          title: expense.category,
                          amount:
                              "${Constants().currencyMap[expense.currency] ?? "\$"} ${expense.amount.toStringAsFixed(2)}",
                          convertedAmount:
                              "\$ ${expense.usdAmount.toStringAsFixed(2)}",
                          date: "today",
                          icon: Icons
                              .shopping_bag_outlined, // You can use a real icon based on category
                        );
                      } else {
                        // Request more data when near the end
                        if ((state).hasMore) {
                          context.read<ExpensesBloc>().add(LoadExpenses());
                        }
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                    childCount:
                        (state as ExpensesLoaded).expenses.length +
                        ((state).hasMore ? 1 : 0),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
