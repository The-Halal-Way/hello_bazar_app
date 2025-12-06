// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hello_bazar/feature/due/data/model/due_history.dart';

class Due {
  final String id;
  final String userTitle;
  final double totalAmount;
  final double dueAmount;
  final DateTime dueDate;
  final List<DueHistory> dueHisory;
  Due({
    required this.id,
    required this.userTitle,
    required this.totalAmount,
    required this.dueAmount,
    required this.dueDate,
    required this.dueHisory,
  });
}
