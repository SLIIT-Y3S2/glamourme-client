import 'dart:ffi';

import 'package:flutter/material.dart';

class TimePill extends StatefulWidget {
  final String time;
  final VoidCallback onPressSelect;
  final bool selected;

  const TimePill({
    super.key,
    required this.time,
    required this.onPressSelect,
    required this.selected,
  });

  @override
  State<TimePill> createState() => _TimePillState();
}

class _TimePillState extends State<TimePill> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        widget.onPressSelect();
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: widget.selected
            ? Theme.of(context).colorScheme.primary
            : Colors.white,
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(widget.time,
          style: widget.selected
              ? Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                  )
              : Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  )),
    );
  }
}
