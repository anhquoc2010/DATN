import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    this.color = ColorStyles.primary1,
    required this.value,
    required this.onChange,
    required this.items,
    this.hint,
    this.decoration,
  });

  final Color color;
  final Function onChange;
  final List<DropdownMenuItem<T>> items;
  final T value;
  final Widget? hint;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: color,
            ),
          ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      margin: const EdgeInsets.all(2),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          onChanged: (value) => onChange(value),
          value: value,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
          hint: hint,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          items: items,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: color,
          ),
        ),
      ),
    );
  }
}
