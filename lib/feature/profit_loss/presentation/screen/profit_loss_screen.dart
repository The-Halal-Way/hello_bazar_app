import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class ProfitLossScreen extends StatefulWidget {
  const ProfitLossScreen({super.key});
  @override
  State<ProfitLossScreen> createState() => _ProfitLossScreenState();
}

class _ProfitLossScreenState extends State<ProfitLossScreen> {
  String _selectedPeriod = 'month'; // 'today', 'week', 'month', 'year'

  // Sample data - replace with actual data
  final Map<String, FinancialData> _financialData = {
    'today': FinancialData(
      revenue: 12450.00,
      costOfGoodsSold: 7800.00,
      operatingExpenses: 2100.00,
      otherIncome: 500.00,
      otherExpenses: 300.00,
      previousPeriodProfit: 2500.00,
    ),
    'week': FinancialData(
      revenue: 85200.00,
      costOfGoodsSold: 52000.00,
      operatingExpenses: 15400.00,
      otherIncome: 2500.00,
      otherExpenses: 1800.00,
      previousPeriodProfit: 16000.00,
    ),
    'month': FinancialData(
      revenue: 342500.00,
      costOfGoodsSold: 215000.00,
      operatingExpenses: 68500.00,
      otherIncome: 8500.00,
      otherExpenses: 6200.00,
      previousPeriodProfit: 58000.00,
    ),
    'year': FinancialData(
      revenue: 4250000.00,
      costOfGoodsSold: 2680000.00,
      operatingExpenses: 825000.00,
      otherIncome: 95000.00,
      otherExpenses: 72000.00,
      previousPeriodProfit: 720000.00,
    ),
  };

  FinancialData get _currentData => _financialData[_selectedPeriod]!;

  double get _grossProfit =>
      _currentData.revenue - _currentData.costOfGoodsSold;
  double get _operatingProfit => _grossProfit - _currentData.operatingExpenses;
  double get _netProfit =>
      _operatingProfit + _currentData.otherIncome - _currentData.otherExpenses;
  double get _profitMargin => (_netProfit / _currentData.revenue) * 100;
  double get _growthRate =>
      ((_netProfit - _currentData.previousPeriodProfit) /
          _currentData.previousPeriodProfit) *
      100;

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
          'Profit & Loss',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download, color: MyColor.onSurfaceVariant),
            onPressed: () {
              // Export P&L statement
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: MyColor.onSurfaceVariant),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Summary Banner
            _buildSummaryBanner(),

            // Period Selector
            _buildPeriodSelector(),

            SizedBox(height: 24.h),

            // Key Metrics Cards
            _buildKeyMetrics(),

            SizedBox(height: 24.h),

            // Detailed Breakdown
            _buildDetailedBreakdown(),

            SizedBox(height: 24.h),

            // Expense Categories
            _buildExpenseCategories(),

            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryBanner() {
    final isProfit = _netProfit >= 0;
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isProfit
              ? [MyColor.success, MyColor.success.withOpacity(0.85)]
              : [MyColor.error, MyColor.error.withOpacity(0.85)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: (isProfit ? MyColor.success : MyColor.error).withOpacity(
              0.25,
            ),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: MyColor.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isProfit ? Icons.trending_up : Icons.trending_down,
                  color: MyColor.white,
                  size: 36.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Net ${isProfit ? 'Profit' : 'Loss'}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: MyColor.onPrimary.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '৳${_netProfit.abs().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: MyColor.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(color: MyColor.white.withOpacity(0.2), height: 1.h),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _buildBannerStat(
                  label: 'Profit Margin',
                  value: '${_profitMargin.toStringAsFixed(1)}%',
                  icon: Icons.percent,
                ),
              ),
              Container(
                width: 1.w,
                height: 50.h,
                color: MyColor.white.withOpacity(0.2),
              ),
              Expanded(
                child: _buildBannerStat(
                  label: 'Growth',
                  value:
                      '${_growthRate >= 0 ? '+' : ''}${_growthRate.toStringAsFixed(1)}%',
                  icon: _growthRate >= 0
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBannerStat({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: MyColor.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: MyColor.white, size: 22.sp),
        ),
        SizedBox(height: 10.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: MyColor.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: MyColor.white.withOpacity(0.85),
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: MyColor.gray100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(child: _buildPeriodOption('Today', 'today')),
          Expanded(child: _buildPeriodOption('Week', 'week')),
          Expanded(child: _buildPeriodOption('Month', 'month')),
          Expanded(child: _buildPeriodOption('Year', 'year')),
        ],
      ),
    );
  }

  Widget _buildPeriodOption(String label, String value) {
    final isSelected = _selectedPeriod == value;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPeriod = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? MyColor.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: MyColor.gray200.withOpacity(0.5),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSelected ? MyColor.primary : MyColor.gray600,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildKeyMetrics() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Metrics',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  icon: Icons.attach_money,
                  label: 'Revenue',
                  value: '৳${_currentData.revenue.toStringAsFixed(0)}',
                  color: MyColor.primary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildMetricCard(
                  icon: Icons.trending_up,
                  label: 'Gross Profit',
                  value: '৳${_grossProfit.toStringAsFixed(0)}',
                  color: MyColor.success,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  icon: Icons.business_center,
                  label: 'Operating Profit',
                  value: '৳${_operatingProfit.toStringAsFixed(0)}',
                  color: MyColor.warning,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildMetricCard(
                  icon: Icons.account_balance_wallet,
                  label: 'Net Profit',
                  value: '৳${_netProfit.toStringAsFixed(0)}',
                  color: _netProfit >= 0 ? MyColor.success : MyColor.error,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: MyColor.gray200.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 24.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: MyColor.gray600),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedBreakdown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          color: MyColor.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: MyColor.outlineVariant, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: MyColor.gray200.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Icon(Icons.receipt_long, color: MyColor.primary, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'Profit & Loss Statement',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1.h, color: MyColor.outlineVariant),

            // Revenue
            _buildStatementRow(
              'Revenue',
              _currentData.revenue,
              isHeader: true,
              color: MyColor.success,
            ),

            // COGS
            _buildStatementRow(
              'Cost of Goods Sold',
              -_currentData.costOfGoodsSold,
              color: MyColor.error,
            ),

            Divider(
              height: 1.h,
              color: MyColor.outlineVariant,
              indent: 16.w,
              endIndent: 16.w,
            ),

            // Gross Profit
            _buildStatementRow(
              'Gross Profit',
              _grossProfit,
              isBold: true,
              color: _grossProfit >= 0 ? MyColor.success : MyColor.error,
            ),

            // Operating Expenses
            _buildStatementRow(
              'Operating Expenses',
              -_currentData.operatingExpenses,
              color: MyColor.error,
            ),

            Divider(
              height: 1.h,
              color: MyColor.outlineVariant,
              indent: 16.w,
              endIndent: 16.w,
            ),

            // Operating Profit
            _buildStatementRow(
              'Operating Profit',
              _operatingProfit,
              isBold: true,
              color: _operatingProfit >= 0 ? MyColor.success : MyColor.error,
            ),

            // Other Income
            _buildStatementRow(
              'Other Income',
              _currentData.otherIncome,
              color: MyColor.success,
            ),

            // Other Expenses
            _buildStatementRow(
              'Other Expenses',
              -_currentData.otherExpenses,
              color: MyColor.error,
            ),

            Divider(height: 1.h, color: MyColor.outlineVariant),

            // Net Profit
            _buildStatementRow(
              'Net Profit/Loss',
              _netProfit,
              isHeader: true,
              isBold: true,
              color: _netProfit >= 0 ? MyColor.success : MyColor.error,
              backgroundColor: _netProfit >= 0
                  ? MyColor.success.withOpacity(0.05)
                  : MyColor.error.withOpacity(0.05),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatementRow(
    String label,
    double amount, {
    bool isHeader = false,
    bool isBold = false,
    Color? color,
    Color? backgroundColor,
  }) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: (isHeader || isBold)
                  ? FontWeight.bold
                  : FontWeight.w500,
              fontSize: isHeader ? 15.sp : 14.sp,
            ),
          ),
          Text(
            '${amount >= 0 ? '' : ''}৳${amount.abs().toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: color ?? MyColor.onSurface,
              fontWeight: (isHeader || isBold)
                  ? FontWeight.bold
                  : FontWeight.w600,
              fontSize: isHeader ? 16.sp : 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseCategories() {
    final expenses = [
      ExpenseCategory(
        'Cost of Goods',
        _currentData.costOfGoodsSold,
        MyColor.error,
      ),
      ExpenseCategory(
        'Operating',
        _currentData.operatingExpenses,
        MyColor.warning,
      ),
      ExpenseCategory('Other', _currentData.otherExpenses, MyColor.gray600),
    ];

    final totalExpenses = expenses.fold(0.0, (sum, e) => sum + e.amount);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          color: MyColor.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: MyColor.outlineVariant, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: MyColor.gray200.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Icon(Icons.pie_chart, color: MyColor.primary, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'Expense Breakdown',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1.h, color: MyColor.outlineVariant),
            ...expenses.map((expense) {
              final percentage = (expense.amount / totalExpenses) * 100;
              return _buildExpenseRow(
                expense.label,
                expense.amount,
                percentage,
                expense.color,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseRow(
    String label,
    double amount,
    double percentage,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '৳${amount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: MyColor.gray600,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: MyColor.gray200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }
}

// Models
class FinancialData {
  final double revenue;
  final double costOfGoodsSold;
  final double operatingExpenses;
  final double otherIncome;
  final double otherExpenses;
  final double previousPeriodProfit;

  FinancialData({
    required this.revenue,
    required this.costOfGoodsSold,
    required this.operatingExpenses,
    required this.otherIncome,
    required this.otherExpenses,
    required this.previousPeriodProfit,
  });
}

class ExpenseCategory {
  final String label;
  final double amount;
  final Color color;

  ExpenseCategory(this.label, this.amount, this.color);
}
