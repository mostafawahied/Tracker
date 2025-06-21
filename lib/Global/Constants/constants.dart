import '../../Index/index.dart';

class Constants {
  final Map<String, String> currencyMap = {
    'USD': '\$',
    'EUR': '€',
    'INR': '₹',
    'GBP': '£',
    'EGP': 'LE',
  };

  final List<CategoryItem> categories = [
    CategoryItem("Groceries", Icons.shopping_cart, Colors.blue.shade100),
    CategoryItem("Entertainment", Icons.movie, Colors.blue),
    CategoryItem("Gas", Icons.local_gas_station, Colors.red.shade100),
    CategoryItem("Shopping", Icons.shopping_bag, Colors.orange.shade100),
    CategoryItem("News Paper", Icons.newspaper, Colors.amber.shade100),
    CategoryItem("Transport", Icons.directions_car, Colors.purple.shade100),
    CategoryItem("Rent", Icons.home_work, Colors.brown.shade100),
    CategoryItem(
      "Add Category",
      Icons.add,
      Colors.transparent,
      isOutline: true,
    ),
  ];
}
