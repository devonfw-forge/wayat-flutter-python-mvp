import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';

/// General purpose Switch
class CustomSwitch extends StatefulWidget {
  /// Whether the switch is enabled or disabled
  final bool value;

  /// Callback executed when the switch changes.
  ///
  /// It recives the state as an argument.
  final Function(bool) onChanged;

  const CustomSwitch({required this.value, required this.onChanged, Key? key})
      : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
        width: 35,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: widget.value
                ? ColorTheme.primaryColor
                : const Color(0xFFDCDCDC)),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment:
              widget.value ? Alignment.centerRight : Alignment.centerLeft,
          curve: Curves.decelerate,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
            ),
          ),
        ),
      ),
    );
  }
}
