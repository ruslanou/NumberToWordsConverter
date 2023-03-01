import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gluon_test/feature/data/models/number_to_words.dart';

part 'converter_event.dart';
part 'converter_state.dart';

class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  ConverterBloc() : super(const ConverterState()) {
    on<ConvertNumberIntoWord>((event, emit) {
      int? num = int.tryParse(state.number!);
      try {
        String convertedNumber = convertNumberToWords(num!);
        emit(state.copyWith(
            status: ConverterStatus.success, convertedNumber: convertedNumber));
      } catch (e) {
        emit(state.copyWith(
            status: ConverterStatus.failure,
            convertedNumber: "THE NUMBER EXCEEDED"));
      }
    });

    on<ChangeIsValidStatus>((event, emit) {
      print("masuk event");
      if (event.value.isEmpty) {
        emit(state.copyWith(
            status: ConverterStatus.success, number: "", isValid: false));
      } else {
        emit(state.copyWith(
            status: ConverterStatus.success,
            number: event.value,
            isValid: true));
      }
    });
  }

  String convertNumberToWords(int number) {
    // If number less than 20
    if (NUMBERS_TO_WORDS.containsKey(number)) {
      return NUMBERS_TO_WORDS[number]!;
    }
    // hundred
    if (number > 20 && number < 100) {
      int tens = (number ~/ 10) * 10;
      int remainder = number % 10;
      return "${NUMBERS_TO_WORDS[tens]} ${NUMBERS_TO_WORDS[remainder]}";
    }
    // thousand
    if (number >= 100 && number < 1000) {
      int hundreds = number ~/ 100;
      int remainder = number % 100;
      if (remainder == 0) {
        return "${NUMBERS_TO_WORDS[hundreds]} hundred";
      } else {
        return "${NUMBERS_TO_WORDS[hundreds]} hundred and ${convertNumberToWords(remainder)}";
      }
    }
    // million
    if (number >= 1000 && number < 1000000) {
      int thousands = number ~/ 1000;
      print(thousands);
      int remainder = number % 1000;
      if (remainder == 0) {
        return "${convertNumberToWords(thousands)} thousands";
      } else {
        return "${convertNumberToWords(thousands)} thousand and ${convertNumberToWords(remainder)}";
      }
    }
    // billion
    if (number >= 1000000 && number < 1000000000) {
      int millions = number ~/ 1000000;
      int remainder = number % 1000000;

      if (remainder == 0) {
        return "${convertNumberToWords(millions)} million";
      } else {
        return "${convertNumberToWords(millions)} million and ${convertNumberToWords(remainder)}";
      }
    }

    // trillion
    if (number >= 1000000000 && number < 1000000000000) {
      int billions = number ~/ 1000000000;
      int remainder = number % 1000000000;

      if (remainder == 0) {
        return "${convertNumberToWords(billions)} billion";
      } else {
        return "${convertNumberToWords(billions)} billion and ${convertNumberToWords(remainder)}";
      }
    }

    // quadrilion
    if (number >= 1000000000000 && number < 1000000000000000) {
      int trillions = number ~/ 1000000000000;
      int remainder = number % 1000000000000;

      if (remainder == 0) {
        return "${convertNumberToWords(trillions)} trillion";
      } else {
        return "${convertNumberToWords(trillions)} trillion and ${convertNumberToWords(remainder)}";
      }
    }

    throw "The number exceeded";
  }
}
