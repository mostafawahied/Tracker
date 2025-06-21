import 'package:flutter_test/flutter_test.dart';

bool isExpenseValid({
  required String category,
  required String amountText,
  required String date,
}) {
  return category.isNotEmpty &&
      double.tryParse(amountText) != null &&
      DateTime.tryParse(date) != null;
}

void main() {
  test('Valid expense input should return true', () {
    expect(
      isExpenseValid(category: 'Food', amountText: '100', date: '2024-06-20'),
      isTrue,
    );
  });

  test('Invalid amount should return false', () {
    expect(
      isExpenseValid(category: 'Food', amountText: 'abc', date: '2024-06-20'),
      isFalse,
    );
  });

  test('Empty category should return false', () {
    expect(
      isExpenseValid(category: '', amountText: '100', date: '2024-06-20'),
      isFalse,
    );
  });
}
