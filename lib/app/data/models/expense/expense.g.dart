// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Expense _$_$_ExpenseFromJson(Map<String, dynamic> json) {
  return _$_Expense(
    id: json['id'] as String,
    mount: (json['mount'] as num).toDouble(),
    categoryId: json['categoryId'] as String,
    persons:
        (json['persons'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$_$_ExpenseToJson(_$_Expense instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mount': instance.mount,
      'categoryId': instance.categoryId,
      'persons': instance.persons,
    };
