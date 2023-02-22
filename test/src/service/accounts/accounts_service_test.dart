// Copyright 2023 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🌎 Project imports:
import 'package:misskey/src/service/accounts/account.dart';
import 'package:misskey/src/service/accounts/accounts_service.dart';
import 'package:misskey/src/service/common/rate_limit.dart';
import 'package:misskey/src/service/response/misskey_response.dart';
// 📦 Package imports:
import 'package:test/test.dart';

import '../../../mocks/client_stubs.dart';
import '../common_expectations.dart';

void main() {
  group('.lookupMe', () {
    test('normal case', () async {
      final accountsService = AccountsService(
        instance: 'test',
        client: buildPostStub(
          'test',
          '/api/i',
          'test/src/service/accounts/data/lookup_me.json',
        ),
      );

      final response = await accountsService.lookupMe();

      expect(response, isA<MisskeyResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Account>());
    });

    test('when unauthorized', () async {
      final accountsService = AccountsService(
        instance: 'test',
        client: buildPostStub(
          'test',
          '/api/i',
          'test/src/service/accounts/data/lookup_me.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await accountsService.lookupMe(),
      );
    });

    test('when rate limit exceeded', () async {
      final accountsService = AccountsService(
        instance: 'test',
        client: buildPostStub(
          'test',
          '/api/i',
          'test/src/service/accounts/data/lookup_me.json',
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await accountsService.lookupMe(),
      );
    });
  });
}
