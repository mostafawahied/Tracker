import 'package:tracker/Index/index.dart';

class ExchangeEntity extends Equatable {
  final String? result;
  final String? baseCode;
  final String? targetCode;
  final num? conversionRate;
  final num? conversionResult;

  const ExchangeEntity({
    this.result,
    this.baseCode,
    this.targetCode,
    this.conversionRate,
    this.conversionResult,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    result,
    baseCode,
    targetCode,
    conversionRate,
    conversionResult,
  ];
}
