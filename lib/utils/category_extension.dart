import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:flutter/material.dart';

extension CategoryExtension on Category {
  IconData get icon => switch (this) {
    Category.food => Icons.restaurant,
    Category.travel => Icons.airplanemode_on,
    Category.shopping => Icons.shopping_bag,
  };
}
