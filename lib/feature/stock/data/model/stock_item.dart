class StockItem {
  final String productId;
  final String productName;
  final String sku;
  final String category;
  int currentStock;
  final int minStock;
  final int maxStock;
  final int reorderPoint;
  final String unit;
  final double costPerUnit;
  final double sellingPricePerUnit;
  DateTime lastRestocked;
  final String supplier;
  final String warehouseLocation;
  final String? barcode;
  final String? batchNumber;
  final DateTime? expiryDate;
  final DateTime? manufacturingDate;
  final bool isActive;

  StockItem({
    required this.productId,
    required this.productName,
    required this.sku,
    required this.category,
    required this.currentStock,
    required this.minStock,
    required this.maxStock,
    required this.reorderPoint,
    required this.unit,
    required this.costPerUnit,
    this.sellingPricePerUnit = 0.0,
    required this.lastRestocked,
    required this.supplier,
    this.warehouseLocation = 'Main Warehouse',
    this.barcode,
    this.batchNumber,
    this.expiryDate,
    this.manufacturingDate,
    this.isActive = true,
  });

  // Getter for stock status with more granular levels
  String get stockStatus {
    if (currentStock <= 0) {
      return 'out-of-stock';
    } else if (currentStock < (minStock * 0.5)) {
      return 'critical';
    } else if (currentStock < minStock) {
      return 'very-low';
    } else if (currentStock < reorderPoint) {
      return 'low';
    } else if (currentStock > maxStock) {
      return 'overstocked';
    } else if (currentStock > (maxStock * 0.9)) {
      return 'high';
    } else {
      return 'adequate';
    }
  }

  // Getter for stock value (current stock value)
  double get stockValue => currentStock * costPerUnit;

  // Getter for potential sales value
  double get potentialSalesValue => currentStock * sellingPricePerUnit;

  // Getter for profit margin per unit
  double get profitMarginPerUnit => sellingPricePerUnit - costPerUnit;

  // Getter for total potential profit
  double get totalPotentialProfit => currentStock * profitMarginPerUnit;

  // Getter to check if needs reorder
  bool get needsReorder => currentStock <= reorderPoint;

  // Getter to check if critical
  bool get isCritical => currentStock < (minStock * 0.5);

  // Getter to check if very low
  bool get isVeryLow => currentStock < minStock;

  // Getter to check if low
  bool get isLow => currentStock < reorderPoint;

  // Getter to check if overstocked
  bool get isOverstocked => currentStock > maxStock;

  // Getter to check if nearly expired (within 30 days)
  bool get isNearlyExpired {
    if (expiryDate == null) return false;
    final now = DateTime.now();
    final daysUntilExpiry = expiryDate!.difference(now).inDays;
    return daysUntilExpiry <= 30 && daysUntilExpiry > 0;
  }

  // Getter to check if expired
  bool get isExpired {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!);
  }

  // Getter for stock percentage (0.0 to 1.0)
  double get stockPercentage {
    if (maxStock <= 0) return 0.0;
    return currentStock / maxStock;
  }

  // Getter for safety stock (buffer stock)
  int get safetyStock => (minStock * 0.2).ceil(); // 20% of min stock as safety

  // Getter for suggested restock quantity
  int get suggestedRestockQuantity {
    if (currentStock >= maxStock) return 0;

    final targetStock = (reorderPoint + maxStock) ~/ 2; // Aim for midpoint
    final neededStock = targetStock - currentStock;

    return neededStock > 0 ? neededStock : 0;
  }

  // Getter for maximum restock quantity (without exceeding max)
  int get maxRestockQuantity => maxStock - currentStock;

  // Getter for days since last restocked
  int get daysSinceLastRestocked {
    final now = DateTime.now();
    return now.difference(lastRestocked).inDays;
  }

  // Getter for days until expiry
  int? get daysUntilExpiry {
    if (expiryDate == null) return null;
    final now = DateTime.now();
    final difference = expiryDate!.difference(now);
    return difference.inDays;
  }

  // Getter for age in days (since manufacturing)
  int? get ageInDays {
    if (manufacturingDate == null) return null;
    final now = DateTime.now();
    return now.difference(manufacturingDate!).inDays;
  }

  // Method to restock (returns new StockItem)
  StockItem restock({
    required int quantity,
    double? newCostPerUnit,
    String? newSupplier,
    String? newBatchNumber,
    DateTime? newExpiryDate,
  }) {
    if (quantity <= 0) return this;

    final newStock = currentStock + quantity;

    return copyWith(
      currentStock: newStock,
      lastRestocked: DateTime.now(),
      costPerUnit: newCostPerUnit ?? costPerUnit,
      supplier: newSupplier ?? supplier,
      batchNumber: newBatchNumber ?? batchNumber,
      expiryDate: newExpiryDate ?? expiryDate,
    );
  }

  // Method to consume stock (returns new StockItem)
  StockItem consume({required int quantity, bool allowNegative = false}) {
    if (quantity <= 0) return this;

    final newStock = currentStock - quantity;
    if (!allowNegative && newStock < 0) {
      throw Exception(
        'Insufficient stock. Current: $currentStock, Requested: $quantity',
      );
    }

    return copyWith(currentStock: newStock > 0 ? newStock : 0);
  }

  // Method to adjust stock (returns new StockItem)
  StockItem adjustStock({required int newQuantity, String? reason}) {
    if (newQuantity < 0) return this;

    return copyWith(currentStock: newQuantity, lastRestocked: DateTime.now());
  }

  // CopyWith method
  StockItem copyWith({
    String? productId,
    String? productName,
    String? sku,
    String? category,
    int? currentStock,
    int? minStock,
    int? maxStock,
    int? reorderPoint,
    String? unit,
    double? costPerUnit,
    double? sellingPricePerUnit,
    DateTime? lastRestocked,
    String? supplier,
    String? warehouseLocation,
    String? barcode,
    String? batchNumber,
    DateTime? expiryDate,
    DateTime? manufacturingDate,
    bool? isActive,
  }) {
    return StockItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      sku: sku ?? this.sku,
      category: category ?? this.category,
      currentStock: currentStock ?? this.currentStock,
      minStock: minStock ?? this.minStock,
      maxStock: maxStock ?? this.maxStock,
      reorderPoint: reorderPoint ?? this.reorderPoint,
      unit: unit ?? this.unit,
      costPerUnit: costPerUnit ?? this.costPerUnit,
      sellingPricePerUnit: sellingPricePerUnit ?? this.sellingPricePerUnit,
      lastRestocked: lastRestocked ?? this.lastRestocked,
      supplier: supplier ?? this.supplier,
      warehouseLocation: warehouseLocation ?? this.warehouseLocation,
      barcode: barcode ?? this.barcode,
      batchNumber: batchNumber ?? this.batchNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      manufacturingDate: manufacturingDate ?? this.manufacturingDate,
      isActive: isActive ?? this.isActive,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'sku': sku,
      'category': category,
      'currentStock': currentStock,
      'minStock': minStock,
      'maxStock': maxStock,
      'reorderPoint': reorderPoint,
      'unit': unit,
      'costPerUnit': costPerUnit,
      'sellingPricePerUnit': sellingPricePerUnit,
      'lastRestocked': lastRestocked.toIso8601String(),
      'supplier': supplier,
      'warehouseLocation': warehouseLocation,
      'barcode': barcode,
      'batchNumber': batchNumber,
      'expiryDate': expiryDate?.toIso8601String(),
      'manufacturingDate': manufacturingDate?.toIso8601String(),
      'isActive': isActive,
      // Computed properties
      'stockStatus': stockStatus,
      'stockValue': stockValue,
      'potentialSalesValue': potentialSalesValue,
      'profitMarginPerUnit': profitMarginPerUnit,
      'totalPotentialProfit': totalPotentialProfit,
      'needsReorder': needsReorder,
      'stockPercentage': stockPercentage,
      'daysSinceLastRestocked': daysSinceLastRestocked,
      'suggestedRestockQuantity': suggestedRestockQuantity,
      'maxRestockQuantity': maxRestockQuantity,
    };
  }

  // From JSON
  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
      productId: json['productId'].toString(),
      productName: json['productName'].toString(),
      sku: json['sku'].toString(),
      category: json['category'].toString(),
      currentStock: json['currentStock'] as int,
      minStock: json['minStock'] as int,
      maxStock: json['maxStock'] as int,
      reorderPoint: json['reorderPoint'] as int,
      unit: json['unit'].toString(),
      costPerUnit: (json['costPerUnit'] as num).toDouble(),
      sellingPricePerUnit: (json['sellingPricePerUnit'] as num? ?? 0.0)
          .toDouble(),
      lastRestocked: DateTime.parse(json['lastRestocked'].toString()),
      supplier: json['supplier'].toString(),
      warehouseLocation:
          json['warehouseLocation']?.toString() ?? 'Main Warehouse',
      barcode: json['barcode']?.toString(),
      batchNumber: json['batchNumber']?.toString(),
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'].toString())
          : null,
      manufacturingDate: json['manufacturingDate'] != null
          ? DateTime.parse(json['manufacturingDate'].toString())
          : null,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  // Equality check
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockItem &&
          runtimeType == other.runtimeType &&
          productId == other.productId;

  @override
  int get hashCode => productId.hashCode;

  // String representation
  @override
  String toString() {
    return 'StockItem{productId: $productId, productName: $productName, currentStock: $currentStock/$maxStock, status: $stockStatus, value: ৳${stockValue.toStringAsFixed(2)}}';
  }

  // Static method to create from raw data
  static StockItem fromRawData(Map<String, dynamic> data) {
    return StockItem(
      productId: data['id']?.toString() ?? data['productId']?.toString() ?? '',
      productName:
          data['name']?.toString() ?? data['productName']?.toString() ?? '',
      sku: data['sku']?.toString() ?? '',
      category: data['category']?.toString() ?? 'Uncategorized',
      currentStock: (data['currentStock'] ?? data['quantity'] ?? 0) as int,
      minStock: (data['minStock'] ?? 10) as int,
      maxStock: (data['maxStock'] ?? 100) as int,
      reorderPoint: (data['reorderPoint'] ?? 20) as int,
      unit: data['unit']?.toString() ?? 'pcs',
      costPerUnit: ((data['costPerUnit'] ?? data['cost'] ?? 0.0) as num)
          .toDouble(),
      sellingPricePerUnit:
          ((data['sellingPricePerUnit'] ?? data['price'] ?? 0.0) as num)
              .toDouble(),
      lastRestocked: data['lastRestocked'] != null
          ? DateTime.parse(data['lastRestocked'].toString())
          : DateTime.now(),
      supplier: data['supplier']?.toString() ?? 'Unknown Supplier',
      warehouseLocation:
          data['warehouseLocation']?.toString() ?? 'Main Warehouse',
      barcode: data['barcode']?.toString(),
      batchNumber: data['batchNumber']?.toString(),
      expiryDate: data['expiryDate'] != null
          ? DateTime.parse(data['expiryDate'].toString())
          : null,
      manufacturingDate: data['manufacturingDate'] != null
          ? DateTime.parse(data['manufacturingDate'].toString())
          : null,
      isActive: (data['isActive'] as bool? ?? true),
    );
  }

  // Static method to create a sample/dummy item
  static StockItem sample({
    String? id,
    String? name,
    String? category,
    int? currentStock,
    int? minStock,
    int? maxStock,
    double? cost,
    double? price,
  }) {
    final randomId =
        id ??
        'PRD${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
    final randomName = name ?? 'Sample Product ${DateTime.now().millisecond}';
    final randomCategory = category ?? 'Sample Category';
    final randomStock = currentStock ?? (20 + DateTime.now().millisecond % 80);
    final randomMin = minStock ?? 10;
    final randomMax = maxStock ?? 100;
    final randomCost = cost ?? (50.0 + (DateTime.now().millisecond % 950));
    final randomPrice = price ?? (randomCost * 1.3); // 30% markup

    return StockItem(
      productId: randomId,
      productName: randomName,
      sku: 'SKU-${randomId.substring(3)}',
      category: randomCategory,
      currentStock: randomStock,
      minStock: randomMin,
      maxStock: randomMax,
      reorderPoint: (randomMin + randomMax) ~/ 4,
      unit: 'pcs',
      costPerUnit: randomCost,
      sellingPricePerUnit: randomPrice,
      lastRestocked: DateTime.now().subtract(
        Duration(days: DateTime.now().millisecond % 30),
      ),
      supplier: 'Sample Supplier Ltd.',
      warehouseLocation: 'Main Warehouse',
      barcode:
          '890${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 10)}',
      batchNumber: 'BATCH-${DateTime.now().year}-${DateTime.now().month}',
      expiryDate: DateTime.now().add(
        Duration(days: 365 + (DateTime.now().millisecond % 365)),
      ),
      manufacturingDate: DateTime.now().subtract(
        Duration(days: 30 + (DateTime.now().millisecond % 30)),
      ),
      isActive: true,
    );
  }
}

// Extension for StockItem list operations
extension StockItemListExtensions on List<StockItem> {
  // Get total stock value
  double get totalStockValue => fold(0.0, (sum, item) => sum + item.stockValue);

  // Get total potential sales value
  double get totalPotentialSalesValue =>
      fold(0.0, (sum, item) => sum + item.potentialSalesValue);

  // Get total potential profit
  double get totalPotentialProfit =>
      fold(0.0, (sum, item) => sum + item.totalPotentialProfit);

  // Get critical items
  List<StockItem> get criticalItems =>
      where((item) => item.isCritical).toList();

  // Get low stock items
  List<StockItem> get lowStockItems => where((item) => item.isLow).toList();

  // Get items needing reorder
  List<StockItem> get needReorderItems =>
      where((item) => item.needsReorder).toList();

  // Get nearly expired items
  List<StockItem> get nearlyExpiredItems =>
      where((item) => item.isNearlyExpired).toList();

  // Get expired items
  List<StockItem> get expiredItems => where((item) => item.isExpired).toList();

  // Get overstocked items
  List<StockItem> get overstockedItems =>
      where((item) => item.isOverstocked).toList();

  // Get active items
  List<StockItem> get activeItems => where((item) => item.isActive).toList();

  // Get inactive items
  List<StockItem> get inactiveItems => where((item) => !item.isActive).toList();

  // Get items by category
  Map<String, List<StockItem>> get itemsByCategory {
    final map = <String, List<StockItem>>{};
    for (final item in this) {
      map.putIfAbsent(item.category, () => []).add(item);
    }
    return map;
  }

  // Get items by supplier
  Map<String, List<StockItem>> get itemsBySupplier {
    final map = <String, List<StockItem>>{};
    for (final item in this) {
      map.putIfAbsent(item.supplier, () => []).add(item);
    }
    return map;
  }

  // Search items
  List<StockItem> search(String query) {
    if (query.isEmpty) return this;

    final lowerQuery = query.toLowerCase();
    return where(
      (item) =>
          item.productName.toLowerCase().contains(lowerQuery) ||
          item.sku.toLowerCase().contains(lowerQuery) ||
          item.category.toLowerCase().contains(lowerQuery) ||
          item.supplier.toLowerCase().contains(lowerQuery) ||
          (item.barcode?.toLowerCase().contains(lowerQuery) ?? false) ||
          (item.batchNumber?.toLowerCase().contains(lowerQuery) ?? false),
    ).toList();
  }

  // Filter by stock status
  List<StockItem> filterByStatus(String status) {
    return where((item) => item.stockStatus == status).toList();
  }

  // Sort by various criteria
  List<StockItem> sortedByStockStatus() {
    final statusOrder = {
      'out-of-stock': 0,
      'critical': 1,
      'very-low': 2,
      'low': 3,
      'adequate': 4,
      'high': 5,
      'overstocked': 6,
    };

    return List.from(this)..sort(
      (a, b) =>
          statusOrder[a.stockStatus]!.compareTo(statusOrder[b.stockStatus]!),
    );
  }

  // Sort by days until expiry (ascending)
  List<StockItem> sortedByExpiry() {
    return List.from(this)..sort((a, b) {
      if (a.daysUntilExpiry == null && b.daysUntilExpiry == null) return 0;
      if (a.daysUntilExpiry == null) return 1;
      if (b.daysUntilExpiry == null) return -1;
      return a.daysUntilExpiry!.compareTo(b.daysUntilExpiry!);
    });
  }

  // Sort by stock value (descending)
  List<StockItem> sortedByStockValue({bool descending = true}) {
    return List.from(this)..sort(
      (a, b) => descending
          ? b.stockValue.compareTo(a.stockValue)
          : a.stockValue.compareTo(b.stockValue),
    );
  }
}
