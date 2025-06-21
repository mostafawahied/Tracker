import 'package:tracker/Index/index.dart';

class DashboardSliverWidget extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String selectedDate;
  final String totalExpenses;
  final void Function(String?)? onChanged;

  DashboardSliverWidget({
    required this.totalExpenses,
    required this.selectedDate,
    this.onChanged,
    required this.expandedHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        DashboardHeaderWidget(
          selectedCurrency: selectedDate,
          onChanged: onChanged,
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Container(),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: 30.w,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: ExpenseCardWidget(
              expandedHeight: expandedHeight,
              totalExpenses: totalExpenses,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
