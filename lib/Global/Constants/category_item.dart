import '../../Index/index.dart';

class CategoryItem {
  final String label;
  final IconData icon;
  final Color color;
  final bool isOutline;

  CategoryItem(this.label, this.icon, this.color, {this.isOutline = false});
}
