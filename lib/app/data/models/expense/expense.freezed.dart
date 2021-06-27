// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  return _Expense.fromJson(json);
}

/// @nodoc
class _$ExpenseTearOff {
  const _$ExpenseTearOff();

  _Expense call(
      {required String id,
      required double mount,
      required String categoryId,
      required List<String> persons}) {
    return _Expense(
      id: id,
      mount: mount,
      categoryId: categoryId,
      persons: persons,
    );
  }

  Expense fromJson(Map<String, Object> json) {
    return Expense.fromJson(json);
  }
}

/// @nodoc
const $Expense = _$ExpenseTearOff();

/// @nodoc
mixin _$Expense {
  String get id => throw _privateConstructorUsedError;
  double get mount => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  List<String> get persons => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseCopyWith<Expense> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCopyWith<$Res> {
  factory $ExpenseCopyWith(Expense value, $Res Function(Expense) then) =
      _$ExpenseCopyWithImpl<$Res>;
  $Res call({String id, double mount, String categoryId, List<String> persons});
}

/// @nodoc
class _$ExpenseCopyWithImpl<$Res> implements $ExpenseCopyWith<$Res> {
  _$ExpenseCopyWithImpl(this._value, this._then);

  final Expense _value;
  // ignore: unused_field
  final $Res Function(Expense) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? mount = freezed,
    Object? categoryId = freezed,
    Object? persons = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mount: mount == freezed
          ? _value.mount
          : mount // ignore: cast_nullable_to_non_nullable
              as double,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      persons: persons == freezed
          ? _value.persons
          : persons // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$ExpenseCopyWith<$Res> implements $ExpenseCopyWith<$Res> {
  factory _$ExpenseCopyWith(_Expense value, $Res Function(_Expense) then) =
      __$ExpenseCopyWithImpl<$Res>;
  @override
  $Res call({String id, double mount, String categoryId, List<String> persons});
}

/// @nodoc
class __$ExpenseCopyWithImpl<$Res> extends _$ExpenseCopyWithImpl<$Res>
    implements _$ExpenseCopyWith<$Res> {
  __$ExpenseCopyWithImpl(_Expense _value, $Res Function(_Expense) _then)
      : super(_value, (v) => _then(v as _Expense));

  @override
  _Expense get _value => super._value as _Expense;

  @override
  $Res call({
    Object? id = freezed,
    Object? mount = freezed,
    Object? categoryId = freezed,
    Object? persons = freezed,
  }) {
    return _then(_Expense(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mount: mount == freezed
          ? _value.mount
          : mount // ignore: cast_nullable_to_non_nullable
              as double,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      persons: persons == freezed
          ? _value.persons
          : persons // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Expense extends _Expense {
  const _$_Expense(
      {required this.id,
      required this.mount,
      required this.categoryId,
      required this.persons})
      : super._();

  factory _$_Expense.fromJson(Map<String, dynamic> json) =>
      _$_$_ExpenseFromJson(json);

  @override
  final String id;
  @override
  final double mount;
  @override
  final String categoryId;
  @override
  final List<String> persons;

  @override
  String toString() {
    return 'Expense(id: $id, mount: $mount, categoryId: $categoryId, persons: $persons)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Expense &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.mount, mount) ||
                const DeepCollectionEquality().equals(other.mount, mount)) &&
            (identical(other.categoryId, categoryId) ||
                const DeepCollectionEquality()
                    .equals(other.categoryId, categoryId)) &&
            (identical(other.persons, persons) ||
                const DeepCollectionEquality().equals(other.persons, persons)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(mount) ^
      const DeepCollectionEquality().hash(categoryId) ^
      const DeepCollectionEquality().hash(persons);

  @JsonKey(ignore: true)
  @override
  _$ExpenseCopyWith<_Expense> get copyWith =>
      __$ExpenseCopyWithImpl<_Expense>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ExpenseToJson(this);
  }
}

abstract class _Expense extends Expense {
  const factory _Expense(
      {required String id,
      required double mount,
      required String categoryId,
      required List<String> persons}) = _$_Expense;
  const _Expense._() : super._();

  factory _Expense.fromJson(Map<String, dynamic> json) = _$_Expense.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  double get mount => throw _privateConstructorUsedError;
  @override
  String get categoryId => throw _privateConstructorUsedError;
  @override
  List<String> get persons => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ExpenseCopyWith<_Expense> get copyWith =>
      throw _privateConstructorUsedError;
}
