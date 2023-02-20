// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// ignore_for_file: invalid_annotation_target

// 📦 Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
class Account with _$Account {
  @JsonSerializable(includeIfNull: false)
  const factory Account({
    required String id,
  }) = _Account;

  factory Account.fromJson(Map<String, Object?> json) =>
      _$AccountFromJson(json);
}
