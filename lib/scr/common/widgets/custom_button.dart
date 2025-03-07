import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.isExpanded,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final bool? isExpanded;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: widget.isExpanded == true ? double.maxFinite : null,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? context.colorExt.backgroungIconColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
