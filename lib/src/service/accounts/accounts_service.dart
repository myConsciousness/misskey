// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import '../../core/client/client_context.dart';
import '../../core/client/user_context.dart';
import '../base_service.dart';
import '../response/misskey_response.dart';
import 'account.dart';

abstract class AccountsService {
  /// Returns the new instance of [AccountsService].
  factory AccountsService({
    required String instance,
    required ClientContext context,
  }) =>
      _AccountsService(
        instance: instance,
        context: context,
      );

  Future<MisskeyResponse<Account>> lookupMe();
}

class _AccountsService extends BaseService implements AccountsService {
  /// Returns the new instance of [_AccountsService].
  _AccountsService({
    required super.instance,
    required super.context,
  });

  @override
  Future<MisskeyResponse<Account>> lookupMe() async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/i',
        ),
        dataBuilder: Account.fromJson,
      );
}
