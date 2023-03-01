import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gluon_test/feature/presentation/widgets/auto_tooltip.dart';

import '../bloc/converter_bloc/converter_bloc.dart';

class CustomTextFieldWithTitle extends StatelessWidget {
  final String title;
  final bool usingLeadingIcon, disable;
  final int? maxLines;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextFieldWithTitle({
    super.key,
    required this.title,
    this.keyboardType,
    this.maxLines,
    this.hintText,
    this.usingLeadingIcon = false,
    this.inputFormatters,
    this.onChanged,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 10),
        BlocBuilder<ConverterBloc, ConverterState>(
          builder: (context, state) {
            return TextFormField(
              maxLines: maxLines ?? 1,
              enabled: !disable,
              cursorColor: Colors.black,
              onChanged: onChanged,
              keyboardType: keyboardType ?? TextInputType.number,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: usingLeadingIcon ? const Icon(Icons.person) : null,
                suffixIcon: state.isValid == null || disable
                    ? null
                    : state.isValid!
                        ? const Icon(Icons.check)
                        : const AutoTooltip(),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.5,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.5,
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.5,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
