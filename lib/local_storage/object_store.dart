import 'package:expense_tracker/objectbox.g.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store);

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    if (kReleaseMode) {
      final docsDir = await getApplicationDocumentsDirectory();
      final store = await openStore(
        directory: p.join(docsDir.path, "com.example.expense-tracker"),
      );
      return ObjectBox._create(store);
    }

    final store = Store(
      getObjectBoxModel(),
      directory: "memory:expense-tracker",
    );
    return ObjectBox._create(store);
  }
}
