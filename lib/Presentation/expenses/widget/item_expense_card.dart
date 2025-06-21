import 'package:tracker/Index/index.dart';

class ItemExpenseCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String amount;
  final String convertedAmount;
  final String date;

  const ItemExpenseCard({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
    required this.icon,
    required this.convertedAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Card(
        color: Colors.white,
        elevation: 0.1,
        child: ListTile(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Text(date),
          leading: CircleAvatar(
            radius: 40.h,
            child: Icon(icon, size: 50.h),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(amount),
              SizedBox(height: 10.h),
              Text(convertedAmount),
            ],
          ),
        ),
      ),
    );
  }
}
