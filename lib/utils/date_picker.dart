import 'package:flutter/material.dart';

void dateDialog(BuildContext context, DateTime? selectedDate,
    Function(DateTime) onDateSelected) async {
  final DateTime picked = (await showDatePicker(
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
    firstDate: DateTime(1800),
    lastDate: DateTime(2101),
  )) ??
      DateTime.now();

  onDateSelected(picked);
}