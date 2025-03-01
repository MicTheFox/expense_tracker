import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Expense extends Equatable {
  @Id()
  int id;
  @Property(type: PropertyType.date)
  DateTime createdAt;

  @Property(type: PropertyType.date)
  DateTime expenseDateTime;
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
    required this.expenseDateTime,
    required this.amount,
    required this.description,
    this.category,
  });

  @override
  List<Object?> get props => [
    id,
    createdAt,
    expenseDateTime,
    amount,
    description,
  ];
}

enum Category {
  food(dbIndex: 1),
  travel(dbIndex: 2),
  shopping(dbIndex: 3);

  const Category({required this.dbIndex});

  final int dbIndex;
}
