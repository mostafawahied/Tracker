import '../../../Index/index.dart';

class CurrencyDropdown extends StatelessWidget {
  final String selectedCurrency;
  final void Function(String?)? onChanged;

  const CurrencyDropdown({
    super.key,
    required this.selectedCurrency,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCurrency,
      decoration: InputDecoration(
        hint: Text("\$50,000"),
        fillColor: ColorConstants.gray,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
      items: Constants().currencyMap.entries.map((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Text('${entry.key} - ${entry.value}'),
        );
      }).toList(),

      onChanged: onChanged,
    );
  }
}
