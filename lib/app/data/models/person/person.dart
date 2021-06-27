import 'package:freezed_annotation/freezed_annotation.dart';

part 'person.freezed.dart';
part 'person.g.dart';

@freezed
abstract class Person implements _$Person {
  const Person._();

  const factory Person({
    required String id,
    required String name,
    required int amountPersons,
    Map<String, bool>? categories,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
