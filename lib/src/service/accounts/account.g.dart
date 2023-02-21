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
          name: $checkedConvert('name', (v) => v as String),
          username: $checkedConvert('username', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          avatarUrl: $checkedConvert('avatarUrl', (v) => v as String),
          avatarId: $checkedConvert('avatarId', (v) => v as String),
          notesCount: $checkedConvert('notesCount', (v) => v as int),
          followersCount: $checkedConvert('followersCount', (v) => v as int),
          followingCount: $checkedConvert('followingCount', (v) => v as int),
          isBot: $checkedConvert('isBot', (v) => v as bool),
          isCat: $checkedConvert('isCat', (v) => v as bool),
          isSuspended: $checkedConvert('isSuspended', (v) => v as bool),
          isLocked: $checkedConvert('isLocked', (v) => v as bool),
          isSilenced: $checkedConvert('isSilenced', (v) => v as bool),
          isModerator: $checkedConvert('isModerator', (v) => v as bool),
          isAdmin: $checkedConvert('isAdmin', (v) => v as bool),
          isDeleted: $checkedConvert('isDeleted', (v) => v as bool),
          createdAt:
              $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
          updatedAt:
              $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_AccountToJson(_$_Account instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'description': instance.description,
      'avatarUrl': instance.avatarUrl,
      'avatarId': instance.avatarId,
      'notesCount': instance.notesCount,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'isBot': instance.isBot,
      'isCat': instance.isCat,
      'isSuspended': instance.isSuspended,
      'isLocked': instance.isLocked,
      'isSilenced': instance.isSilenced,
      'isModerator': instance.isModerator,
      'isAdmin': instance.isAdmin,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
