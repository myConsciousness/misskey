// Copyright 2023 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'package:misskey/misskey.dart';

Future<void> main() async {
  //! You need to specify misskey instance (domain) you want to access.
  final misskey = MisskeyApi(
    instance: 'misskey.io',
    accessToken: 'YOUR_ACCESS_TOKEN',

    //! Automatic retry is available when server error or network error occurs
    //! when communicating with the API.
    retryConfig: RetryConfig(
      maxAttempts: 5,
      onExecute: (event) => print(
        'Retry after ${event.intervalInSeconds} seconds...'
        '[${event.retryCount} times]',
      ),
    ),

    //! The default timeout is 10 seconds.
    timeout: Duration(seconds: 20),
  );

  try {
    final me = await misskey.accounts.lookupMe();

    print(me);
  } on MisskeyException catch (e) {
    print(e);
  }
}
