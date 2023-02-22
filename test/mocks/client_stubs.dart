// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

// 🌎 Project imports:
import 'mock.mocks.dart';

MockClient buildPostStub(
  final String instance,
  final String unencodedPath,
  final String resourcePath, {
  int statusCode = 200,
}) {
  final mockClient = MockClient();
  final requestUri = Uri.https(instance, unencodedPath, {});

  when(mockClient.post(
    requestUri,
    headers: anyNamed('headers'),
    body: anyNamed('body'),
  )).thenAnswer(
    (_) async => Response(
      await File(resourcePath).readAsString(),
      statusCode,
      headers: {
        'content-type': 'application/json; charset=utf-8',
      },
      request: Request(
        'POST',
        requestUri,
      ),
    ),
  );

  return mockClient;
}
