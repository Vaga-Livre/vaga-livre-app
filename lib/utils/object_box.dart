import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:vagalivre/objectbox.g.dart';

class ObjectBox {
  static Store? _objStore;
  static Store get store {
    assert(
      _objStore != null,
      'You must initialize the obejctbox instance before calling [ObjectBox.store]',
    );

    return _objStore!;
  }

  static Future<void> initialize() async {
    if (_objStore == null) {
      final docsDir = await getApplicationDocumentsDirectory();
      // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
      _objStore = await openStore(directory: p.join(docsDir.path, "vaga-livre-db"));
    }
  }
}
