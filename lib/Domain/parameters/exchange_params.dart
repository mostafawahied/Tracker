class ExchangeParams {
  final String? targetCurrency;
  final String? baseCode;
  final num? amount;

  ExchangeParams({this.targetCurrency, this.amount, this.baseCode});

  /// ✅ Convert to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (targetCurrency != null && targetCurrency!.isNotEmpty) {
      data['target_code'] = targetCurrency;
    }
    if (baseCode != null && baseCode!.isNotEmpty) {
      data['base_code'] = baseCode;
    }
    if (amount != null) {
      data['amount'] = amount;
    }
    return data;
  }

  /// ✅ Create a modified copy
  ExchangeParams copyWith({String? fromDate, String? endDate}) {
    return ExchangeParams(
      targetCurrency: targetCurrency,
      amount: amount,
      baseCode: baseCode,
    );
  }
}
