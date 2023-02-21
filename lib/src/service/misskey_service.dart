// Copyright 2023 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🌎 Project imports:
import '../core/client/client.dart';
import '../core/config/retry_config.dart';
import 'accounts/accounts_service.dart';

abstract class MisskeyService {
  /// Returns the new instance of [MisskeyService].
  factory MisskeyService({
    required String instance,
    required String accessToken,
    Duration timeout = const Duration(seconds: 10),
    RetryConfig? retryConfig,
  }) =>
      _MisskeyService(
        instance: instance,
        accessToken: accessToken,
        timeout: timeout,
        retryConfig: retryConfig,
      );

  /// Returns the accounts service.
  AccountsService get accounts;
}

class _MisskeyService implements MisskeyService {
  /// Returns the new instance of [_MisskeyService].
  _MisskeyService({
    required String instance,
    required String accessToken,
    required Duration timeout,
    RetryConfig? retryConfig,
  }) : accounts = AccountsService(
          instance: instance,
          client: Client(
            accessToken: accessToken,
            timeout: timeout,
            retryConfig: retryConfig,
          ),
        );

  @override
  final AccountsService accounts;
}
