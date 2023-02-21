// Copyright 2023 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';

// 📦 Package imports:
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';

// 🌎 Project imports:
import '../config/retry_config.dart';
import 'retry_policy.dart';

abstract class Client {
  /// Returns the new instance of [Client].
  factory Client({
    required String accessToken,
    required Duration timeout,
    RetryConfig? retryConfig,
  }) =>
      _Client(
        accessToken: accessToken,
        timeout: timeout,
        retryConfig: retryConfig,
      );

  Future<http.Response> post(
    Uri uri, {
    Map<String, String> headers = const {},
    dynamic body,
  });
}

class _Client implements Client {
  /// Returns the new instance of [_Client].
  _Client({
    required String accessToken,
    required this.timeout,
    RetryConfig? retryConfig,
  })  : _accessToken = accessToken,
        _retryPolicy = RetryPolicy(retryConfig);

  /// The token to authenticate OAuth 2.0
  final String _accessToken;

  /// The policy of retry.
  final RetryPolicy _retryPolicy;

  /// The timeout
  final Duration timeout;

  @override
  Future<http.Response> post(
    Uri uri, {
    Map<String, String> headers = const {},
    dynamic body,
  }) async =>
      await _challengeWithRetryIfNecessary(
        this,
        (client) async => await http
            .post(
              uri,
              headers: headers,
              body: jsonEncode(
                {
                  'i': _accessToken,
                  ...(body ?? {}),
                },
              ),
              encoding: utf8,
            )
            .timeout(timeout),
      );

  dynamic _challengeWithRetryIfNecessary(
    final Client client,
    final dynamic Function(Client client) challenge, {
    int retryCount = 0,
  }) async {
    try {
      final response = await challenge.call(client);

      if (response.statusCode == 500 || response.statusCode == 503) {
        if (_retryPolicy.shouldRetry(retryCount)) {
          return await _retry(client, challenge, retryCount: ++retryCount);
        }
      }

      return response;
    } on SocketException {
      if (_retryPolicy.shouldRetry(retryCount)) {
        return await _retry(client, challenge, retryCount: ++retryCount);
      }

      rethrow;
    } on TimeoutException {
      if (_retryPolicy.shouldRetry(retryCount)) {
        return await _retry(client, challenge, retryCount: ++retryCount);
      }

      rethrow;
    }
  }

  dynamic _retry(
    final Client client,
    final dynamic Function(Client client) challenge, {
    int retryCount = 0,
  }) async {
    await _retryPolicy.wait(retryCount);

    return await _challengeWithRetryIfNecessary(
      client,
      challenge,
      retryCount: retryCount,
    );
  }
}
