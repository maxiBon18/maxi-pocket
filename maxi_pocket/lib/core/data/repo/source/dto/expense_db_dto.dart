import 'package:flutter/material.dart' show Locale;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesType;
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart' show ExpenseCommitmentEntity;

part 'expense_db_dto.freezed.dart';
part 'expense_db_dto.g.dart';

/// Parses a stored locale string (e.g. `'en_US'`) back into a [Locale].
///
/// Falls back to a language-only [Locale] when [value] has no country part.
Locale localeFromString(String value) {
  final List<String> parts = value.split('_');
  return parts.length > 1 ? Locale(parts[0], parts[1]) : Locale(parts[0]);
}

/// Serializes [locale] to the string format expected by [localeFromString].
String localeToString(Locale locale) => locale.toString();

/// Marker for DTOs that can be inserted via [ExpensesDbSourceImpl.insertQuery].
abstract class ExpenseDbInsertDto {}

/// Shared expense fields present in every expense type (subscription and financing).
///
/// Embed this in type-specific DTOs instead of duplicating these fields.
@Freezed()
abstract class ExpenseDbDto with _$ExpenseDbDto {
  const ExpenseDbDto._();

  const factory ExpenseDbDto({
    required String name,
    required MaxiPocketExpensesType eventType,
    required DateTime eventDate,
    required String localeTimezone,
    BigInt? id,
  }) = _ExpenseDbDto;

  factory ExpenseDbDto.fromJson(Map<String, Object?> json) => _$ExpenseDbDtoFromJson(json);

  /// Reconstructs an [ExpenseCommitmentEntity] from this DTO.
  ExpenseCommitmentEntity toEntity() => ExpenseCommitmentEntity(
    name: name,
    eventDate: eventDate,
    eventType: eventType,
    id: id,
    localeTimezone: localeTimezone,
  );
}
