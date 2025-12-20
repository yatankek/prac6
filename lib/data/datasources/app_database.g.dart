part of 'app_database.dart';

class $CartItemsTable extends CartItems
    with TableInfo<$CartItemsTable, CartItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dishIdMeta = const VerificationMeta('dishId');
  @override
  late final GeneratedColumn<String> dishId = GeneratedColumn<String>(
    'dish_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [dishId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CartItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('dish_id')) {
      context.handle(
        _dishIdMeta,
        dishId.isAcceptableOrUnknown(data['dish_id']!, _dishIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dishIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dishId};
  @override
  CartItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartItem(
      dishId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dish_id'],
      )!,
    );
  }

  @override
  $CartItemsTable createAlias(String alias) {
    return $CartItemsTable(attachedDatabase, alias);
  }
}

class CartItem extends DataClass implements Insertable<CartItem> {
  final String dishId;
  const CartItem({required this.dishId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['dish_id'] = Variable<String>(dishId);
    return map;
  }

  CartItemsCompanion toCompanion(bool nullToAbsent) {
    return CartItemsCompanion(dishId: Value(dishId));
  }

  factory CartItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartItem(dishId: serializer.fromJson<String>(json['dishId']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'dishId': serializer.toJson<String>(dishId)};
  }

  CartItem copyWith({String? dishId}) =>
      CartItem(dishId: dishId ?? this.dishId);
  CartItem copyWithCompanion(CartItemsCompanion data) {
    return CartItem(
      dishId: data.dishId.present ? data.dishId.value : this.dishId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartItem(')
          ..write('dishId: $dishId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => dishId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartItem && other.dishId == this.dishId);
}

class CartItemsCompanion extends UpdateCompanion<CartItem> {
  final Value<String> dishId;
  final Value<int> rowid;
  const CartItemsCompanion({
    this.dishId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CartItemsCompanion.insert({
    required String dishId,
    this.rowid = const Value.absent(),
  }) : dishId = Value(dishId);
  static Insertable<CartItem> custom({
    Expression<String>? dishId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dishId != null) 'dish_id': dishId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CartItemsCompanion copyWith({Value<String>? dishId, Value<int>? rowid}) {
    return CartItemsCompanion(
      dishId: dishId ?? this.dishId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dishId.present) {
      map['dish_id'] = Variable<String>(dishId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartItemsCompanion(')
          ..write('dishId: $dishId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoriteItemsTable extends FavoriteItems
    with TableInfo<$FavoriteItemsTable, FavoriteItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dishIdMeta = const VerificationMeta('dishId');
  @override
  late final GeneratedColumn<String> dishId = GeneratedColumn<String>(
    'dish_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [dishId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('dish_id')) {
      context.handle(
        _dishIdMeta,
        dishId.isAcceptableOrUnknown(data['dish_id']!, _dishIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dishIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dishId};
  @override
  FavoriteItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteItem(
      dishId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dish_id'],
      )!,
    );
  }

  @override
  $FavoriteItemsTable createAlias(String alias) {
    return $FavoriteItemsTable(attachedDatabase, alias);
  }
}

class FavoriteItem extends DataClass implements Insertable<FavoriteItem> {
  final String dishId;
  const FavoriteItem({required this.dishId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['dish_id'] = Variable<String>(dishId);
    return map;
  }

  FavoriteItemsCompanion toCompanion(bool nullToAbsent) {
    return FavoriteItemsCompanion(dishId: Value(dishId));
  }

  factory FavoriteItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteItem(dishId: serializer.fromJson<String>(json['dishId']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'dishId': serializer.toJson<String>(dishId)};
  }

  FavoriteItem copyWith({String? dishId}) =>
      FavoriteItem(dishId: dishId ?? this.dishId);
  FavoriteItem copyWithCompanion(FavoriteItemsCompanion data) {
    return FavoriteItem(
      dishId: data.dishId.present ? data.dishId.value : this.dishId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteItem(')
          ..write('dishId: $dishId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => dishId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteItem && other.dishId == this.dishId);
}

class FavoriteItemsCompanion extends UpdateCompanion<FavoriteItem> {
  final Value<String> dishId;
  final Value<int> rowid;
  const FavoriteItemsCompanion({
    this.dishId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteItemsCompanion.insert({
    required String dishId,
    this.rowid = const Value.absent(),
  }) : dishId = Value(dishId);
  static Insertable<FavoriteItem> custom({
    Expression<String>? dishId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dishId != null) 'dish_id': dishId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteItemsCompanion copyWith({Value<String>? dishId, Value<int>? rowid}) {
    return FavoriteItemsCompanion(
      dishId: dishId ?? this.dishId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dishId.present) {
      map['dish_id'] = Variable<String>(dishId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteItemsCompanion(')
          ..write('dishId: $dishId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CartItemsTable cartItems = $CartItemsTable(this);
  late final $FavoriteItemsTable favoriteItems = $FavoriteItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cartItems,
    favoriteItems,
  ];
}

typedef $$CartItemsTableCreateCompanionBuilder =
    CartItemsCompanion Function({required String dishId, Value<int> rowid});
typedef $$CartItemsTableUpdateCompanionBuilder =
    CartItemsCompanion Function({Value<String> dishId, Value<int> rowid});

class $$CartItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get dishId => $composableBuilder(
    column: $table.dishId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CartItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get dishId => $composableBuilder(
    column: $table.dishId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CartItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get dishId =>
      $composableBuilder(column: $table.dishId, builder: (column) => column);
}

class $$CartItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CartItemsTable,
          CartItem,
          $$CartItemsTableFilterComposer,
          $$CartItemsTableOrderingComposer,
          $$CartItemsTableAnnotationComposer,
          $$CartItemsTableCreateCompanionBuilder,
          $$CartItemsTableUpdateCompanionBuilder,
          (CartItem, BaseReferences<_$AppDatabase, $CartItemsTable, CartItem>),
          CartItem,
          PrefetchHooks Function()
        > {
  $$CartItemsTableTableManager(_$AppDatabase db, $CartItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> dishId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CartItemsCompanion(dishId: dishId, rowid: rowid),
          createCompanionCallback:
              ({
                required String dishId,
                Value<int> rowid = const Value.absent(),
              }) => CartItemsCompanion.insert(dishId: dishId, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CartItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CartItemsTable,
      CartItem,
      $$CartItemsTableFilterComposer,
      $$CartItemsTableOrderingComposer,
      $$CartItemsTableAnnotationComposer,
      $$CartItemsTableCreateCompanionBuilder,
      $$CartItemsTableUpdateCompanionBuilder,
      (CartItem, BaseReferences<_$AppDatabase, $CartItemsTable, CartItem>),
      CartItem,
      PrefetchHooks Function()
    >;
typedef $$FavoriteItemsTableCreateCompanionBuilder =
    FavoriteItemsCompanion Function({required String dishId, Value<int> rowid});
typedef $$FavoriteItemsTableUpdateCompanionBuilder =
    FavoriteItemsCompanion Function({Value<String> dishId, Value<int> rowid});

class $$FavoriteItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteItemsTable> {
  $$FavoriteItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get dishId => $composableBuilder(
    column: $table.dishId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteItemsTable> {
  $$FavoriteItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get dishId => $composableBuilder(
    column: $table.dishId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteItemsTable> {
  $$FavoriteItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get dishId =>
      $composableBuilder(column: $table.dishId, builder: (column) => column);
}

class $$FavoriteItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteItemsTable,
          FavoriteItem,
          $$FavoriteItemsTableFilterComposer,
          $$FavoriteItemsTableOrderingComposer,
          $$FavoriteItemsTableAnnotationComposer,
          $$FavoriteItemsTableCreateCompanionBuilder,
          $$FavoriteItemsTableUpdateCompanionBuilder,
          (
            FavoriteItem,
            BaseReferences<_$AppDatabase, $FavoriteItemsTable, FavoriteItem>,
          ),
          FavoriteItem,
          PrefetchHooks Function()
        > {
  $$FavoriteItemsTableTableManager(_$AppDatabase db, $FavoriteItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> dishId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoriteItemsCompanion(dishId: dishId, rowid: rowid),
          createCompanionCallback:
              ({
                required String dishId,
                Value<int> rowid = const Value.absent(),
              }) => FavoriteItemsCompanion.insert(dishId: dishId, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteItemsTable,
      FavoriteItem,
      $$FavoriteItemsTableFilterComposer,
      $$FavoriteItemsTableOrderingComposer,
      $$FavoriteItemsTableAnnotationComposer,
      $$FavoriteItemsTableCreateCompanionBuilder,
      $$FavoriteItemsTableUpdateCompanionBuilder,
      (
        FavoriteItem,
        BaseReferences<_$AppDatabase, $FavoriteItemsTable, FavoriteItem>,
      ),
      FavoriteItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CartItemsTableTableManager get cartItems =>
      $$CartItemsTableTableManager(_db, _db.cartItems);
  $$FavoriteItemsTableTableManager get favoriteItems =>
      $$FavoriteItemsTableTableManager(_db, _db.favoriteItems);
}
