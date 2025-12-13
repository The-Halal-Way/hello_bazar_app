class DuePurchase {
  final String id;
  final String date;
  final String time;
  final List<String> items;
  final double totalAmount;
  final double paidAmount;
  final double dueAmount;
  final String status; // 'paid', 'partial', 'unpaid'

  DuePurchase({
    required this.id,
    required this.date,
    required this.time,
    required this.items,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.status,
  });
}
