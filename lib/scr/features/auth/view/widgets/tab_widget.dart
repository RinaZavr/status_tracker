import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';

class TabWidget extends StatefulWidget {
  const TabWidget({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.title,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final String title;

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widget.isSelected ? context.colorExt.lightBorderColor : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.title,
          style: context.textExt.normal,
        ),
      ),
    );
  }
}
