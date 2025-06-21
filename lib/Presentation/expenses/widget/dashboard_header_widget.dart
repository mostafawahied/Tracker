import 'package:tracker/Index/index.dart';

class DashboardHeaderWidget extends StatelessWidget {
  final String selectedCurrency;
  final void Function(String?)? onChanged;

  const DashboardHeaderWidget({
    super.key,
    required this.selectedCurrency,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstants.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 120.h, left: 30.w, right: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 60.h,
              backgroundImage: AssetImage(ImagesConstants.profile),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  Text(
                    "Good morning",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Mostafa",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            CardDropdown<String>(
              value: selectedCurrency,
              items: const ['This month', 'last 7 days'],
              itemText: (currency) => currency,
              onChanged: onChanged,
              hintText: 'Select data',
            ),
          ],
        ),
      ),
    );
  }
}
