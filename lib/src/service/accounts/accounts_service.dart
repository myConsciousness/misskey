// Copyright 2023 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🌎 Project imports:
import '../../core/client/client.dart';
import '../base_service.dart';
import '../response/misskey_response.dart';
import 'account.dart';

abstract class AccountsService {
  /// Returns the new instance of [AccountsService].
  factory AccountsService({
    required String instance,
    required Client client,
  }) =>
      _AccountsService(
        instance: instance,
        client: client,
      );

  /// Lookup authenticated user.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/i
  ///
  /// ## Reference
  ///
  /// - https://misskey-hub.net/docs/api/endpoints/i.html
  Future<MisskeyResponse<Account>> lookupMe();
}

class _AccountsService extends BaseService implements AccountsService {
  /// Returns the new instance of [_AccountsService].
  _AccountsService({
    required super.instance,
    required super.client,
  });

  @override
  Future<MisskeyResponse<Account>> lookupMe() async =>
      super.transformSingleDataResponse(
        await super.post('/api/i'),
        dataBuilder: Account.fromJson,
      );
}
