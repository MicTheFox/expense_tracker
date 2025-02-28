import 'package:objectbox/objectbox.dart';

@Entity()
class Expense {
  @Id()
  int id;
  @Property(type: PropertyType.date)
  DateTime createdAt;
  double amount;
  String description;

  @Transient()
  Category? category;

  int? get dbCategory {
    return category?.dbIndex;
  }

  set dbCategory(int? value) {
    if (value == null) {
      category = null;
      return;
    }

    try {
      category = Category.values.singleWhere(
        (category) => category.dbIndex == value,
      );
    } catch (_) {
      category = null;
    }
  }

  Expense({
    this.id = 0,
    required this.createdAt,
    required this.amount,
    required this.description,
    this.category,
  });
}

enum Category {
  food(dbIndex: 1),
  travel(dbIndex: 2),
  shopping(dbIndex: 3);

  const Category({required this.dbIndex});

  final int dbIndex;
}
