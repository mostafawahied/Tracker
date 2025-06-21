import 'package:flutter_test/flutter_test.dart';

double convertToUSD(double amount, double rate) {
  return amount * rate;
}

void main() {
  test('Currency conversion should be correct', () {
    expect(convertToUSD(100, 1.2), 120.0);
    expect(convertToUSD(0, 1.2), 0.0);
    expect(convertToUSD(50.5, 1.1), closeTo(55.55, 0.01));
  });
}
