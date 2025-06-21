// ignore_for_file: use_super_parameters

import '../../Index/index.dart';

class ExchangeModel extends ExchangeEntity {
  const ExchangeModel({
    final String? result,
    final String? baseCode,
    final String? targetCode,
    final num? conversionRate,
    final num? conversionResult,
  }) : super(
         result: result,
         baseCode: baseCode,
         targetCode: targetCode,
         conversionRate: conversionRate,
         conversionResult: conversionResult,
       );

  factory ExchangeModel.fromJson(Map<String, dynamic> json) {
    return ExchangeModel(
      result: json['result'],
      baseCode: json['base_code'],
      targetCode: json['target_code'],
      conversionRate: json['conversion_rate'],
      conversionResult: json['conversion_result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'message': baseCode,
      'target_code': targetCode,
      'conversion_rate': conversionRate,
      'conversion_result': conversionResult,
    };
  }
}
