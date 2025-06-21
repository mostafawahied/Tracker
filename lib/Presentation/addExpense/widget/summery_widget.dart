import '../../../Index/index.dart';

class SummeryWidget extends StatelessWidget {
  final String category;
  final String amount;
  final String date;
  final String attachment;
  final String currency;
  final String convertedAmount;
  final void Function()? onPressed;

  const SummeryWidget({
    super.key,
    required this.category,
    required this.amount,
    required this.date,
    required this.attachment,
    required this.currency,
    required this.convertedAmount,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    String? currencyValue = Constants().currencyMap[currency];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Categories",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(category, style: TextStyle(fontSize: 18)),
          SizedBox(height: 12),
          Text(
            "Amount",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text("$currencyValue $amount", style: TextStyle(fontSize: 18)),
          SizedBox(height: 12),
          Text(
            "Date",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(date, style: TextStyle(fontSize: 18)),
          SizedBox(height: 12),
          Text(
            "Attachment",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(attachment, style: TextStyle(fontSize: 18)),
          SizedBox(height: 12),
          Text(
            "Converted Amount",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text("\$ $convertedAmount", style: TextStyle(fontSize: 18)),
          SizedBox(height: 12),
          const Spacer(),
          PrimaryButtonWidget(title: 'Submit', onPressed: onPressed),
        ],
      ),
    );
  }
}
