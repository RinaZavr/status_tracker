import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';

class CalendarButton extends StatefulWidget {
  const CalendarButton({super.key, required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  State<CalendarButton> createState() => _CalendarButtonState();
}

class _CalendarButtonState extends State<CalendarButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: Icon(widget.icon),
      style: IconButton.styleFrom(
        backgroundColor: context.colorExt.backgroungIconColor,
        foregroundColor: context.colorExt.textColor,
        side: BorderSide(
          color: context.colorExt.lightBorderColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        disabledBackgroundColor: context.colorExt.lightBorderColor,
      ),
    );
  }
}
