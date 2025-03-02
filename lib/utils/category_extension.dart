import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:flutter/material.dart';

extension CategoryExtension on Category {
  IconData get icon => switch (this) {
    Category.food => Icons.restaurant_outlined,
    Category.travel => Icons.airplanemode_on_outlined,
    Category.shopping => Icons.shopping_bag_outlined,
  };

  String get displayName => switch (this) {
    Category.food => 'Food',
    Category.travel => 'Travel',
    Category.shopping => 'Shopping',
  };

  static List<DropdownMenuItem<Category>> get dropdownItems =>
      Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Row(
                spacing: 8,
                children: [
                  CircleAvatar(child: Icon(category.icon)),
                  Text(category.displayName),
                ],
              ),
            ),
          )
          .toList();
}
