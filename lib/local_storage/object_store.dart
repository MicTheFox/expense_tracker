import 'package:expense_tracker/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectStore {
  /// The Store of this app.
  late final Store store;

  ObjectStore._create(this.store);

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectStore> create({bool isInMemory = false}) async {
    if (isInMemory) {
      final store = Store(
        getObjectBoxModel(),
        directory: "memory:expense-tracker",
      );
      return ObjectStore._create(store);
    }

    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: p.join(docsDir.path, "com.example.expense-tracker"),
    );
    return ObjectStore._create(store);
  }
}
