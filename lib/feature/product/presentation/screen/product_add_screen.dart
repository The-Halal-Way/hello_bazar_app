import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});
  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _priceController = TextEditingController();
  final _costController = TextEditingController();
  final _stockController = TextEditingController();
  final _minStockController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'Grains';
  String _selectedUnit = 'pcs';
  String? _imagePath;
  bool _trackStock = true;

  // New fields for dates
  DateTime? _productionDate;
  DateTime? _expiryDate;
  final TextEditingController _productionDateController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();

  final List<String> _categories = [
    'Grains',
    'Cooking Oil',
    'Sugar & Salt',
    'Flour',
    'Beverages',
    'Dairy',
    'Snacks',
    'Organic',
    'Frozen Foods',
    'Spices',
    'Other',
  ];

  final List<String> _units = ['pcs', 'kg', 'gm', 'ltr', 'ml', 'box', 'pack'];

  @override
  void initState() {
    super.initState();
    // Set initial production date to today
    _productionDate = DateTime.now();
    _productionDateController.text = DateFormat(
      'dd/MM/yyyy',
    ).format(DateTime.now());

    // Set default expiry date to 1 year from now
    _expiryDate = DateTime.now().add(Duration(days: 365));
    _expiryDateController.text = DateFormat('dd/MM/yyyy').format(_expiryDate!);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _barcodeController.dispose();
    _priceController.dispose();
    _costController.dispose();
    _stockController.dispose();
    _minStockController.dispose();
    _descriptionController.dispose();
    _productionDateController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  Future<void> _selectProductionDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _productionDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColor.primary,
              onPrimary: MyColor.onPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _productionDate) {
      setState(() {
        _productionDate = picked;
        _productionDateController.text = DateFormat(
          'dd/MM/yyyy',
        ).format(picked);
      });
    }
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate ?? DateTime.now().add(Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColor.primary,
              onPrimary: MyColor.onPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _expiryDate) {
      setState(() {
        _expiryDate = picked;
        _expiryDateController.text = DateFormat('dd/MM/yyyy').format(picked);

        // Calculate and show shelf life in days
        if (_productionDate != null) {
          final shelfLife = picked.difference(_productionDate!).inDays;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Shelf Life: $shelfLife days'),
              backgroundColor: MyColor.success,
              duration: Duration(seconds: 3),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColor.surface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: MyColor.onSurfaceVariant),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Product',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Card
                _buildHeaderCard(),

                SizedBox(height: 24.h),

                // Product Image Section
                _buildImagePicker(),

                SizedBox(height: 24.h),

                // Basic Information
                _buildSectionTitle('Basic Information'),
                SizedBox(height: 16.h),

                _buildTextField(
                  controller: _nameController,
                  label: 'Product Name',
                  hint: 'Enter product name',
                  icon: Icons.inventory_2_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _skuController,
                        label: 'SKU',
                        hint: 'e.g., RICE-5KG-001',
                        icon: Icons.qr_code,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter SKU';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category *',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.h),
                          _buildCategoryDropdown(),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                _buildTextField(
                  controller: _barcodeController,
                  label: 'Barcode (Optional)',
                  hint: 'Scan or enter barcode',
                  icon: Icons.barcode_reader,
                  keyboardType: TextInputType.number,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.qr_code_scanner, color: MyColor.primary),
                    onPressed: () {
                      // Scan barcode
                    },
                  ),
                ),

                SizedBox(height: 24.h),

                // Pricing Information
                _buildSectionTitle('Pricing'),
                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _priceController,
                        label: 'Selling Price (৳)',
                        hint: '0.00',
                        icon: Icons.attach_money,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter price';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Invalid price';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildTextField(
                        controller: _costController,
                        label: 'Cost Price (৳)',
                        hint: '0.00',
                        icon: Icons.money_off,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter cost';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Invalid cost';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Profit Display
                if (_priceController.text.isNotEmpty &&
                    _costController.text.isNotEmpty)
                  _buildProfitDisplay(),

                SizedBox(height: 24.h),

                // Inventory Information
                _buildSectionTitle('Inventory'),
                SizedBox(height: 16.h),

                _buildStockTrackingToggle(),

                if (_trackStock) ...[
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _stockController,
                          label: 'Current Stock',
                          hint: '0',
                          icon: Icons.inventory,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (_trackStock &&
                                (value == null || value.isEmpty)) {
                              return 'Enter stock';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildTextField(
                          controller: _minStockController,
                          label: 'Min. Stock Alert',
                          hint: '0',
                          icon: Icons.warning_amber,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (_trackStock &&
                                (value == null || value.isEmpty)) {
                              return 'Enter min stock';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Production Date
                  _buildDateField(
                    controller: _productionDateController,
                    label: 'Production Date',
                    hint: 'Select production date',
                    icon: Icons.date_range,
                    onTap: () => _selectProductionDate(context),
                  ),

                  SizedBox(height: 16.h),

                  // Expiry Date
                  _buildDateField(
                    controller: _expiryDateController,
                    label: 'Expiry Date',
                    hint: 'Select expiry date',
                    icon: Icons.event_busy,
                    onTap: () => _selectExpiryDate(context),
                    isRequired: false,
                    validator: (value) {
                      if (_productionDate != null && _expiryDate != null) {
                        if (_expiryDate!.isBefore(_productionDate!)) {
                          return 'Expiry date cannot be before production date';
                        }

                        // Show warning if expiry is within 30 days
                        final daysUntilExpiry = _expiryDate!
                            .difference(DateTime.now())
                            .inDays;
                        if (daysUntilExpiry <= 30) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Warning: Product will expire in $daysUntilExpiry days',
                              ),
                              backgroundColor: MyColor.warning,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 16.h),

                  // Shelf Life Indicator
                  if (_productionDate != null && _expiryDate != null)
                    _buildShelfLifeIndicator(),

                  SizedBox(height: 16.h),

                  Text(
                    'Unit *',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildUnitSelector(),
                ],

                SizedBox(height: 24.h),

                // Additional Information
                _buildSectionTitle('Additional Information (Optional)'),
                SizedBox(height: 16.h),

                _buildTextField(
                  controller: _descriptionController,
                  label: 'Description',
                  hint: 'Enter product description...',
                  icon: Icons.description_outlined,
                  maxLines: 4,
                ),

                SizedBox(height: 32.h),

                // Action Buttons
                _buildActionButtons(),

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            MyColor.primary.withOpacity(0.1),
            MyColor.primary.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: MyColor.primary.withOpacity(0.2), width: 1.w),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: MyColor.primary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.add_shopping_cart,
              color: MyColor.onPrimary,
              size: 28.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Product Entry',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Fill in the details to add a new product',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: MyColor.gray600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 140.w,
            height: 140.h,
            decoration: BoxDecoration(
              color: MyColor.gray100,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: MyColor.outlineVariant, width: 2.w),
            ),
            child: _imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.asset(_imagePath!, fit: BoxFit.cover),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        size: 50.sp,
                        color: MyColor.gray400,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Product Image',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: MyColor.gray500),
                      ),
                    ],
                  ),
          ),
          SizedBox(height: 12.h),
          TextButton.icon(
            onPressed: () {
              // Image picker logic here
              setState(() {
                // _imagePath = 'path_to_image';
              });
            },
            icon: Icon(Icons.camera_alt, size: 18.sp),
            label: Text('Upload Image'),
            style: TextButton.styleFrom(foregroundColor: MyColor.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: (value) {
            if (controller == _priceController ||
                controller == _costController) {
              setState(() {}); // Rebuild to update profit display
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: maxLines > 1
                ? Padding(
                    padding: EdgeInsets.only(bottom: (maxLines * 20).h),
                    child: Icon(icon),
                  )
                : Icon(icon),
            suffixIcon: suffixIcon,
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required VoidCallback onTap,
    bool isRequired = true,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label + (isRequired ? ' *' : ' (Optional)'),
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: onTap,
          child: IgnorePointer(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                prefixIcon: Icon(icon),
                suffixIcon: Icon(Icons.calendar_today, color: MyColor.primary),
              ),
              validator: validator,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShelfLifeIndicator() {
    if (_productionDate == null || _expiryDate == null) {
      return SizedBox();
    }

    final shelfLife = _expiryDate!.difference(_productionDate!).inDays;
    Color indicatorColor;
    String statusText;
    IconData statusIcon;

    if (shelfLife <= 30) {
      indicatorColor = MyColor.error;
      statusText = 'SHORT SHELF LIFE';
      statusIcon = Icons.warning;
    } else if (shelfLife <= 90) {
      indicatorColor = MyColor.warning;
      statusText = 'MODERATE SHELF LIFE';
      statusIcon = Icons.info;
    } else {
      indicatorColor = MyColor.success;
      statusText = 'LONG SHELF LIFE';
      statusIcon = Icons.check_circle;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: indicatorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: indicatorColor, width: 1.w),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: indicatorColor, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shelf Life',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$shelfLife days',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: indicatorColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: indicatorColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        statusText,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: indicatorColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedCategory,
      isExpanded: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.category),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
      items: _categories.map((category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category, overflow: TextOverflow.ellipsis, maxLines: 1),
        );
      }).toList(),
      onChanged: (value) => setState(() => _selectedCategory = value!),
    );
  }

  Widget _buildProfitDisplay() {
    final price = double.tryParse(_priceController.text) ?? 0;
    final cost = double.tryParse(_costController.text) ?? 0;
    final profit = price - cost;
    final margin = price > 0 ? (profit / price * 100) : 0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: profit >= 0
            ? MyColor.success.withOpacity(0.1)
            : MyColor.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: profit >= 0 ? MyColor.success : MyColor.error,
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                profit >= 0 ? Icons.trending_up : Icons.trending_down,
                color: profit >= 0 ? MyColor.success : MyColor.error,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Profit per unit:',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '৳${profit.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: profit >= 0 ? MyColor.success : MyColor.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${margin.toStringAsFixed(1)}% margin',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: MyColor.gray600,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockTrackingToggle() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: _trackStock
                      ? MyColor.primary.withOpacity(0.1)
                      : MyColor.gray200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.inventory_outlined,
                  color: _trackStock ? MyColor.primary : MyColor.gray500,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Track Inventory',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _trackStock
                        ? 'Inventory tracking enabled'
                        : 'Inventory tracking disabled',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: MyColor.gray500),
                  ),
                ],
              ),
            ],
          ),
          Switch(
            value: _trackStock,
            onChanged: (value) {
              setState(() {
                _trackStock = value;
              });
            },
            activeThumbColor: MyColor.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildUnitSelector() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _units.map((unit) {
        final isSelected = _selectedUnit == unit;
        return InkWell(
          onTap: () {
            setState(() {
              _selectedUnit = unit;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? MyColor.primary.withOpacity(0.1)
                  : MyColor.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isSelected ? MyColor.primary : MyColor.outlineVariant,
                width: isSelected ? 2.w : 1.w,
              ),
            ),
            child: Text(
              unit,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? MyColor.primary : MyColor.gray600,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: MyColor.outline),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: MyColor.gray700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Create product object with new fields
                final newProduct = Product(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: _nameController.text,
                  category: _selectedCategory,
                  sku: _skuController.text,
                  price: double.parse(_priceController.text),
                  cost: double.parse(_costController.text),
                  stock: _trackStock ? int.parse(_stockController.text) : 0,
                  minStock: _trackStock
                      ? int.parse(_minStockController.text)
                      : 0,
                  unit: _selectedUnit,
                  image: _imagePath ?? '',
                  status: _trackStock
                      ? (int.parse(_stockController.text) <=
                                int.parse(_minStockController.text)
                            ? 'low_stock'
                            : 'in_stock')
                      : 'in_stock',
                  barcode: _barcodeController.text,
                  productionDate: _productionDate,
                  expiryDate: _expiryDate,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product added successfully!'),
                    backgroundColor: MyColor.success,
                  ),
                );
                Navigator.pop(context, newProduct);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColor.primary,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check, color: MyColor.onPrimary, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Add Product',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: MyColor.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Updated Product Model with new fields
class Product {
  final String id;
  final String name;
  final String category;
  final String sku;
  final double price;
  final double cost;
  final int stock;
  final int minStock;
  final String unit;
  final String image;
  final String status;
  final String barcode;
  final DateTime? productionDate;
  final DateTime? expiryDate;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.sku,
    required this.price,
    required this.cost,
    required this.stock,
    required this.minStock,
    required this.unit,
    required this.image,
    required this.status,
    required this.barcode,
    this.productionDate,
    this.expiryDate,
  });
}
