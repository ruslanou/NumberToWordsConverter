part of 'converter_bloc.dart';

abstract class ConverterEvent {}

class ConvertNumberIntoWord extends ConverterEvent{
  final String value;
  ConvertNumberIntoWord(this.value);
}

class ChangeIsValidStatus extends ConverterEvent {
  final String value;
  ChangeIsValidStatus(this.value);
}
