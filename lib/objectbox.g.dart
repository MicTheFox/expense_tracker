// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'expense/data_models/expense.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 422305482666604764),
      name: 'Expense',
      lastPropertyId: const obx_int.IdUid(7, 4488204021591096762),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 4405789186634515785),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 8362812997783158609),
            name: 'createdAt',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 5784288804656172070),
            name: 'amount',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 2810562080635506394),
            name: 'dbCategory',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 9030875546464937255),
            name: 'description',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 785828489845107416),
            name: 'expenseDateTime',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 4488204021591096762),
            name: 'currency',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(1, 422305482666604764),
      lastIndexId: const obx_int.IdUid(0, 0),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    Expense: obx_int.EntityDefinition<Expense>(
        model: _entities[0],
        toOneRelations: (Expense object) => [],
        toManyRelations: (Expense object) => {},
        getId: (Expense object) => object.id,
        setId: (Expense object, int id) {
          object.id = id;
        },
        objectToFB: (Expense object, fb.Builder fbb) {
          final descriptionOffset = fbb.writeString(object.description);
          final currencyOffset = fbb.writeString(object.currency);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.createdAt.millisecondsSinceEpoch);
          fbb.addFloat64(2, object.amount);
          fbb.addInt64(3, object.dbCategory);
          fbb.addOffset(4, descriptionOffset);
          fbb.addInt64(5, object.expenseDateTime.millisecondsSinceEpoch);
          fbb.addOffset(6, currencyOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final createdAtParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0));
          final expenseDateTimeParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0));
          final amountParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final currencyParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 16, '');
          final descriptionParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 12, '');
          final object = Expense(
              id: idParam,
              createdAt: createdAtParam,
              expenseDateTime: expenseDateTimeParam,
              amount: amountParam,
              currency: currencyParam,
              description: descriptionParam)
            ..dbCategory = const fb.Int64Reader()
                .vTableGetNullable(buffer, rootOffset, 10);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [Expense] entity fields to define ObjectBox queries.
class Expense_ {
  /// See [Expense.id].
  static final id =
      obx.QueryIntegerProperty<Expense>(_entities[0].properties[0]);

  /// See [Expense.createdAt].
  static final createdAt =
      obx.QueryDateProperty<Expense>(_entities[0].properties[1]);

  /// See [Expense.amount].
  static final amount =
      obx.QueryDoubleProperty<Expense>(_entities[0].properties[2]);

  /// See [Expense.dbCategory].
  static final dbCategory =
      obx.QueryIntegerProperty<Expense>(_entities[0].properties[3]);

  /// See [Expense.description].
  static final description =
      obx.QueryStringProperty<Expense>(_entities[0].properties[4]);

  /// See [Expense.expenseDateTime].
  static final expenseDateTime =
      obx.QueryDateProperty<Expense>(_entities[0].properties[5]);

  /// See [Expense.currency].
  static final currency =
      obx.QueryStringProperty<Expense>(_entities[0].properties[6]);
}
