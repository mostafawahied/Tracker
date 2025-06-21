import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final String result;

  const AppError(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}
