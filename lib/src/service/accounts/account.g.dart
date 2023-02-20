// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Account _$$_AccountFromJson(Map json) => $checkedCreate(
      r'_$_Account',
      json,
      ($checkedConvert) {
        final val = _$_Account(
          id: $checkedConvert('id', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_AccountToJson(_$_Account instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
