import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:news_app_ui/utils/app_style.dart';

class DateTimePickerFormField extends StatelessWidget {
  final DateFormat format;
  final DateTime initialDate;
  final bool editable;
  final InputDecoration decoration;
  final ValueChanged<DateTime> onChanged;

  const DateTimePickerFormField({
    Key? key,
    required this.format,
    required this.initialDate,
    required this.editable,
    required this.decoration,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: decoration,
      controller: TextEditingController(text: format.format(initialDate)),
      style: Styles.captionBold.neutral2(context),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(1900),
          lastDate: DateTime(2050),
        );
        if (pickedDate != null && pickedDate != initialDate) {
          onChanged(pickedDate);
        }
      },
    );
  }
}
