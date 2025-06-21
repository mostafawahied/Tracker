import 'package:tracker/Index/index.dart';

class SubExpenseCardWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String amount;

  const SubExpenseCardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.h,
                backgroundColor: ColorConstants.blue3,
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              SizedBox(width: 20.w),
              Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
            ],
          ),
          Text(
            amount,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 27, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
