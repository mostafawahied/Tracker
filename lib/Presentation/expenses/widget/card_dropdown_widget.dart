import 'package:flutter/material.dart';

class CardDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String Function(T)? itemText;
  final Widget Function(T)? itemIcon;
  final ValueChanged<T?>? onChanged;
  final String hintText;
  final double elevation;

  const CardDropdown({
    super.key,
    required this.value,
    required this.items,
    this.itemText,
    this.itemIcon,
    this.onChanged,
    this.hintText = 'Select',
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: false,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Row(
                children: [
                  if (itemIcon != null) ...[
                    itemIcon!(item),
                    const SizedBox(width: 6),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(
                      itemText != null ? itemText!(item) : item.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
          hint: Text(
            hintText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).hintColor,
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
        ),
      ),
    );
  }
}
