import 'package:tracker/Index/index.dart';

class ExpenseCardWidget extends StatelessWidget {
  final double expandedHeight;
  final String totalExpenses;

  const ExpenseCardWidget({
    super.key,
    required this.expandedHeight,
    required this.totalExpenses,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.1,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstants.blue2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Total Expenses",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Icon(Icons.keyboard_arrow_up, color: Colors.white),
                          Spacer(),
                          Icon(Icons.more_horiz, color: Colors.white),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        totalExpenses,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 27, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 60.h),
                    Row(
                      children: [
                        SubExpenseCardWidget(
                          title: 'Income',
                          icon: Icons.arrow_downward,
                          amount: "\$10,000",
                        ),
                        Spacer(),
                        SubExpenseCardWidget(
                          title: 'Expenses',
                          icon: Icons.arrow_upward,
                          amount: totalExpenses,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
