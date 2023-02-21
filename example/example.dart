// Copyright 2023 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'package:misskey/misskey.dart';

Future<void> main() async {
  final misskey = MisskeyApi(
    instance: 'misskey.io',
    accessToken: 'YOUR_ACCESS_TOKEN',
  );

  try {
    final me = await misskey.accounts.lookupMe();

    print(me);
  } on MisskeyException catch (e) {
    print(e);
  }
}
