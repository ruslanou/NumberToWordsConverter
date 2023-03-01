import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gluon_test/feature/presentation/widgets/custom_textfield_with_title.dart';

import '../bloc/converter_bloc/converter_bloc.dart';

class ConverterPage extends StatelessWidget {
  const ConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConverterBloc, ConverterState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: const Color(0Xff354C89),
            leading: const Icon(Icons.dehaze),
            title: const Text("Converter App"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    "Please enter an integer number in the \"Input\" box and tap on \"Convert\" to see the equivalent in words appear in the \"Output\" box"),
                const SizedBox(height: 50),
                CustomTextFieldWithTitle(
                  title: "Input",
                  hintText: "Input",
                  onChanged: (value) {
                    context
                        .read<ConverterBloc>()
                        .add(ChangeIsValidStatus(value));
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(height: 40),
                CustomTextFieldWithTitle(
                  title: "Output",
                  hintText: state.convertedNumber,
                  disable: true,
                  maxLines: 5,
                ),
                const SizedBox(height: 100),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(
                          color: Colors.black,
                          width: 3,
                        ))),
                    onPressed: () {
                      if (state.isValid != null && state.isValid!) {
                        context
                            .read<ConverterBloc>()
                            .add(ConvertNumberIntoWord(state.number!));
                      }
                    },
                    child: const Text(
                      "Convert",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
