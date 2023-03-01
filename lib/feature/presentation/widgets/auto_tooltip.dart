import 'package:flutter/material.dart';

class AutoTooltip extends StatefulWidget {
  const AutoTooltip({super.key});

  @override
  State<AutoTooltip> createState() => _AutoTooltipState();
}

class _AutoTooltipState extends State<AutoTooltip> {
  final tooltipkey = GlobalKey();
  bool isTooltipShow = false;

  void showAndCloseTooltip() async {
    await Future.delayed(const Duration(milliseconds: 10));
    final dynamic tooltip = tooltipkey.currentState;
    tooltip?.ensureTooltipVisible();
    isTooltipShow = true;
  }

  @override
  void initState() {
    showAndCloseTooltip();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      key: tooltipkey,
      message: "This field cannot be empty",
      preferBelow: false,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      triggerMode: TooltipTriggerMode.manual,
      child: InkWell(
        onTap: () {
          dynamic tooltip = tooltipkey.currentState;
          print(tooltip.runtimeType);
          if (!isTooltipShow) {
            tooltip.ensureTooltipVisible();
            isTooltipShow = !isTooltipShow;
          } else {
            tooltip.deactivate();
            isTooltipShow = !isTooltipShow;
          }
        },
        child: const Icon(
          Icons.info,
          color: Colors.red,
        ),
      ),
    );
  }
}
