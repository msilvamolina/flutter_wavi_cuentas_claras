import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
abstract class Expense implements _$Expense {
  const Expense._();

  const factory Expense({
    required String id,
    required double mount,
    required String categoryId,
    required List<String> persons,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
}
