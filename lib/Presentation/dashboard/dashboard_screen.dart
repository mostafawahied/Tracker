import 'package:tracker/Index/index.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  List<PersistentTabConfig> _tabs() => [
    PersistentTabConfig(
      screen: const ExpensesScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.home),
        inactiveIcon: const Icon(Icons.home_outlined),
      ),
    ),
    PersistentTabConfig(
      screen: const ChartsScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.bar_chart),
        inactiveIcon: const Icon(Icons.bar_chart_outlined),
      ),
    ),
    PersistentTabConfig(
      screen: AddExpenseScreen(onExpenseAdded: _refreshExpensesAndReturnHome),
      item: ItemConfig(
        icon: const Icon(Icons.add, color: Colors.white),
        inactiveIcon: const Icon(Icons.add_outlined, color: Colors.white),
      ),
    ),
    PersistentTabConfig(
      screen: const WalletScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.wallet),
        inactiveIcon: const Icon(Icons.wallet_outlined),
      ),
    ),
    PersistentTabConfig(
      screen: const ProfileScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.person),
        inactiveIcon: const Icon(Icons.person_outline),
      ),
    ),
  ];

  void _refreshExpensesAndReturnHome() {
    _controller.jumpToTab(0); // Go to Home tab (index 0)
    context.read<ExpensesBloc>().add(LoadExpenses(isInitial: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        tabs: _tabs(),
        controller: _controller,
        navBarBuilder: (navBarConfig) =>
            Style15BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
