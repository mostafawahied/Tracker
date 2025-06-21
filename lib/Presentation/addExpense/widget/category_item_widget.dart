import 'package:tracker/Index/index.dart';

class CategoryItemWidget extends StatelessWidget {
  final CategoryItem item;
  final bool selected;

  const CategoryItemWidget({
    super.key,
    required this.item,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: item.isOutline ? Colors.transparent : item.color,
            border: item.isOutline
                ? Border.all(color: Colors.blue, width: 1.5)
                : null,
          ),
          padding: EdgeInsets.all(14),
          child: Icon(
            item.icon,
            color: item.isOutline ? Colors.blue : Colors.black,
          ),
        ),
        SizedBox(height: 6),
        Text(
          item.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: item.isOutline ? Colors.blue : Colors.black,
          ),
        ),
      ],
    );
  }
}
