part of 'converter_bloc.dart';

enum ConverterStatus { initial, success, failure }

class ConverterState extends Equatable{
  final bool? isValid;
  final ConverterStatus status;
  final String? number;
  final String? convertedNumber;
  const ConverterState({
    this.status = ConverterStatus.initial,
    this.convertedNumber,
    this.isValid,
    this.number,
  });

  ConverterState copyWith({
    bool? isValid,
    ConverterStatus? status,
    String? number, convertedNumber
  }) {
    return ConverterState(
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      number: number ?? this.number,
      convertedNumber: convertedNumber ?? this.convertedNumber,
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [isValid, status, number, convertedNumber];
}
