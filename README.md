
<p align="center">
  <a href="https://github.com/misskey-dart/misskey">
    <img alt="misskey" width="600px" src="https://user-images.githubusercontent.com/13072231/220250629-eae9c596-1ad9-4c56-b1fa-cc1568f4e459.png">
  </a>
</p>

<p align="center">
  <b>The Easiest and Powerful Dart/Flutter Library for Misskey API 🎯</b>
</p>

---

[![GitHub Sponsor](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=ff69b4)](https://github.com/sponsors/myConsciousness)
[![GitHub Sponsor](https://img.shields.io/static/v1?label=Maintainer&message=myConsciousness&logo=GitHub&color=00acee)](https://github.com/myConsciousness)

[![pub package](https://img.shields.io/pub/v/misskey.svg?logo=dart&logoColor=00b9fc)](https://pub.dartlang.org/packages/misskey)
[![Dart SDK Version](https://badgen.net/pub/sdk-version/misskey)](https://pub.dev/packages/misskey/)
[![Test](https://github.com/misskey-dart/misskey/actions/workflows/test.yml/badge.svg)](https://github.com/misskey-dart/misskey/actions/workflows/test.yml)
[![Analyzer](https://github.com/misskey-dart/misskey/actions/workflows/analyzer.yml/badge.svg)](https://github.com/misskey-dart/misskey/actions/workflows/analyzer.yml)
[![codecov](https://codecov.io/gh/misskey-dart/misskey/branch/main/graph/badge.svg?token=J5GT1PF9Y3)](https://codecov.io/gh/misskey-dart/misskey)
[![Issues](https://img.shields.io/github/issues/misskey-dart/misskey?logo=github&logoColor=white)](https://github.com/misskey-dart/misskey/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/misskey-dart/misskey?logo=github&logoColor=white)](https://github.com/misskey-dart/misskey/pulls)
[![Stars](https://img.shields.io/github/stars/misskey-dart/misskey?logo=github&logoColor=white)](https://github.com/misskey-dart/misskey)
[![Contributors](https://img.shields.io/github/contributors/misskey-dart/misskey)](https://github.com/misskey-dart/misskey/graphs/contributors)
[![Code size](https://img.shields.io/github/languages/code-size/misskey-dart/misskey?logo=github&logoColor=white)](https://github.com/misskey-dart/misskey)
[![Last Commits](https://img.shields.io/github/last-commit/misskey-dart/misskey?logo=git&logoColor=white)](https://github.com/misskey-dart/misskey/commits/main)
[![License](https://img.shields.io/github/license/misskey-dart/misskey?logo=open-source-initiative&logoColor=green)](https://github.com/misskey-dart/misskey/blob/main/LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](https://github.com/misskey-dart/misskey/blob/main/CODE_OF_CONDUCT.md)

---

<!-- TOC -->

- [1. Guide 🌎](#1-guide-)
  - [1.1. Features 💎](#11-features-)
  - [1.2. Getting Started ⚡](#12-getting-started-)
    - [1.2.1. Install Library](#121-install-library)
    - [1.2.2. Import](#122-import)
    - [1.2.3. Implementation](#123-implementation)
  - [1.3. Supported Endpoints 👀](#13-supported-endpoints-)
  - [1.4. Tips 🏄](#14-tips-)
    - [1.4.1. Method Names](#141-method-names)
    - [1.4.2. Null Parameter at Request](#142-null-parameter-at-request)
    - [1.4.3. Change the Timeout Duration](#143-change-the-timeout-duration)
    - [1.4.4. Automatic Retry](#144-automatic-retry)
      - [1.4.4.1. Exponential Backoff and Jitter](#1441-exponential-backoff-and-jitter)
      - [1.4.4.2. Do Something on Retry](#1442-do-something-on-retry)
    - [1.4.5. Thrown Exceptions](#145-thrown-exceptions)
  - [1.5. Contribution 🏆](#15-contribution-)
  - [1.6. Contributors ✨](#16-contributors-)
  - [1.7. Support ❤️](#17-support-️)
  - [1.8. License 🔑](#18-license-)
  - [1.9. More Information 🧐](#19-more-information-)

<!-- /TOC -->

# 1. Guide 🌎

This library provides the easiest way to use [Misskey API](https://misskey-hub.net/docs/api) in **Dart** and **Flutter** apps.

**Show some ❤️ and star the repo to support the project.**

## 1.1. Features 💎

✅ The **wrapper library** for **[Misskey API](https://misskey-hub.net/docs/api)**. </br>
✅ **Easily integrates** with the **Dart** & **Flutter** apps. </br>
✅ Provides response objects with a **guaranteed safe types.** </br>
✅ **Well documented** and **well tested**.</br>
✅ Supports the powerful **automatic retry**.</br>

## 1.2. Getting Started ⚡

### 1.2.1. Install Library

**With Dart:**

```bash
 dart pub add misskey
```

**Or With Flutter:**

```bash
 flutter pub add misskey
```

### 1.2.2. Import

```dart
import 'package:misskey/misskey.dart';
```

### 1.2.3. Implementation

```dart
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
  } on UnauthorizedException catch (e) {
    print(e);
  } on RateLimitExceededException catch (e) {
    print(e);
  } on MisskeyException catch (e) {
    print(e);
  }
}
```

## 1.3. Supported Endpoints 👀

## 1.4. Tips 🏄

### 1.4.1. Method Names

**misskey** uses the following standard prefixes depending on endpoint characteristics. So it's very easy to find the method corresponding to the endpoint you want to use!

| Prefix      | Description                                                               |
| ----------- | ------------------------------------------------------------------------- |
| **lookup**  | This prefix is attached to endpoints that reference toots, accounts, etc. |
| **create**  | This prefix is attached to the endpoint performing the create state.      |
| **destroy** | This prefix is attached to the endpoint performing the destroy state.     |

### 1.4.2. Null Parameter at Request

In this library, parameters that are not required at request time, i.e., optional parameters, are defined as nullable.
However, developers do not need to be aware of the null parameter when sending requests when using this library.

It means the parameters specified with a null value are safely removed and ignored before the request is sent.

For example, arguments specified with null are ignored in the following request.

```dart
import 'package:misskey/misskey.dart';

Future<void> main() async {
  final misskey = MisskeyApi(
    instance: 'misskey.io',
    accessToken: 'YOUR_ACCESS_TOKEN',
  );

  await misskey.notes.createNote(
    text: 'Ai',

    //! These parameters are ignored at request because they are null.
    poll: null,
    sensitive: null,
  );
}
```

### 1.4.3. Change the Timeout Duration

The library specifies a default timeout of **10 seconds** for all API communications.

However, there may be times when you wish to specify an arbitrary timeout duration. If there is such a demand, an arbitrary timeout duration can be specified as follows.

```dart
import 'package:misskey/misskey.dart';

Future<void> main() {
 final misskey = MisskeyApi(
    instance: 'misskey.io',
    accessToken: 'YOUR_ACCESS_TOKEN',

    //! The default timeout is 10 seconds.
    timeout: Duration(seconds: 20),
  );
}
```

### 1.4.4. Automatic Retry

Due to the nature of this library's communication with external systems, timeouts may occur due to inevitable communication failures or temporary crashes of the server to which requests are sent.

When such timeouts occur, an effective countermeasure in many cases is to send the request again after a certain interval. And **misskey** provides an **automatic retry** feature as a solution to this problem.

Also, errors subject to retry are as follows.

- When the status code of the response returned from Misskey instance is `500` or `503`.
- When the network is temporarily lost and a `SocketException` is thrown.
- When communication times out temporarily and a `TimeoutException` is thrown

#### 1.4.4.1. Exponential Backoff and Jitter

Although the algorithm introduced earlier that exponentially increases the retry interval is already powerful, some may believe that it is not yet sufficient to distribute the sensation of retries. It's more distributed than equally spaced retries, but retries still occur at static intervals.

This problem can be solved by adding a random number called **Jitter**, and this method is called the **Exponential Backoff and Jitter** algorithm. By adding a random number to the exponentially increasing retry interval, the retry interval can be distributed more flexibly.

Similar to the previous example, **misskey** can be implemented as follows.

```dart
import 'package:misskey/misskey.dart';

Future<void> main() async {
  final misskey = MisskeyApi(
    instance: 'misskey.io',
    accessToken: 'YOUR_ACCESS_TOKEN',

    //! Add these lines.
    retryConfig: RetryConfig(
      maxAttempts: 3,
    ),
  );
}
```

In the above implementation, the interval increases exponentially for each retry count with jitter. It can be expressed by next formula.

> **(2 ^ retryCount) + jitter(Random Number between 0 ~ 3)**

#### 1.4.4.2. Do Something on Retry

It would be useful to output logging on retries and a popup notifying the user that a retry has been executed. So **misskey** provides callbacks that can perform arbitrary processing when retries are executed.

It can be implemented as follows.

```dart
import 'package:misskey/misskey.dart';

Future<void> main() async {
  final misskey = MisskeyApi(
    instance: 'misskey.io',
    accessToken: 'YOUR_ACCESS_TOKEN',
    retryConfig: RetryConfig(
      maxAttempts: 3,

      //! Add this line.
      onExecute: (event) => print('Retrying... ${event.retryCount} times.'),
    ),
  );
}
```

The [RetryEvent](https://pub.dev/documentation/misskey/latest/misskey/RetryEvent-class.html) passed to the callback contains information on retries.

### 1.4.5. Thrown Exceptions

**misskey** provides a convenient exception object for easy handling of exceptional responses and errors returned from Misskey API.

| Exception                                                                                                                | Description                                                                                                           |
| ------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------- |
| [MisskeyException](https://pub.dev/documentation/misskey/latest/misskey/MisskeyException-class.html)                     | The most basic exception object. For example, it can be used to search for posts that have already been deleted, etc. |
| [UnauthorizedException](https://pub.dev/documentation/misskey/latest/misskey/UnauthorizedException-class.html)           | Thrown when authentication fails with the specified access token.                                                     |
| [RateLimitExceededException](https://pub.dev/documentation/misskey/latest/misskey/RateLimitExceededException-class.html) | Thrown when the request rate limit is exceeded.                                                                       |
| [DataNotFoundException](https://pub.dev/documentation/misskey/latest/misskey/DataNotFoundException-class.html)           | Thrown when response has no body or data field in body string, or when 404 status is returned.                        |

Also, all of the above exceptions thrown from the **misskey** process extend [MisskeyException](https://pub.dev/documentation/misskey/latest/misskey/MisskeyException-class.html). This means that you can take all exceptions as [MisskeyException](https://pub.dev/documentation/misskey/latest/misskey/MisskeyException-class.html) or handle them as certain exception types, depending on the situation.

However note that, if you receive an individual type exception, be sure to define the process so that the individual exception type is cached before [MisskeyException](https://pub.dev/documentation/misskey/latest/misskey/MisskeyException-class.html). Otherwise, certain type exceptions will also be caught as [MisskeyException](https://pub.dev/documentation/misskey/latest/misskey/MisskeyException-class.html).

Therefore, if you need to catch a specific type of exception in addition to [MisskeyException](https://pub.dev/documentation/misskey/latest/misskey/MisskeyException-class.html), be sure to catch [MisskeyException](https://pub.dev/documentation/misskey/latest/misskey/MisskeyException-class.html) in the bottom catch clause as in the following example.

```dart
import 'package:misskey/misskey.dart';

Future<void> main() async {
  final misskey = MisskeyApi(
    instance: 'misskey.io',
    accessToken: 'YOUR_ACCESS_TOKEN',
  );

  try {
    final response = await misskey.notes.createNote(text: 'Yay!');

    print(response);
  } on UnauthorizedException catch (e) {
    print(e);
  } on RateLimitExceededException catch (e) {
    print(e);
  } on MisskeyException catch (e) {
    print(e);
  }
}
```

## 1.5. Contribution 🏆

If you would like to contribute to **misskey**, please create an [issue](https://github.com/misskey-dart/misskey/issues) or create a Pull Request.

There are many ways to contribute to the OSS. For example, the following subjects can be considered:

- There are request parameters or response fields that are not implemented.
- Documentation is outdated or incomplete.
- Have a better way or idea to achieve the functionality.
- etc...

You can see more details from resources below:

- [Contributor Covenant Code of Conduct](https://github.com/misskey-dart/misskey/blob/main/CODE_OF_CONDUCT.md)
- [Contribution Guidelines](https://github.com/misskey-dart/misskey/blob/main/CONTRIBUTING.md)
- [Style Guide](https://github.com/misskey-dart/misskey/blob/main/STYLEGUIDE.md)

Or you can create a [discussion](https://github.com/misskey-dart/misskey/discussions) if you like.

**Feel free to join this development, diverse opinions make software better!**

## 1.6. Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

## 1.7. Support ❤️

The simplest way to show us your support is by **giving the project a star** at [GitHub](https://github.com/misskey-dart/misskey) and [Pub.dev](https://pub.dev/packages/misskey).

You can also support this project by **becoming a sponsor** on GitHub:

<div align="left">
  <p>
    <a href="https://github.com/sponsors/myconsciousness">
      <img src="https://cdn.ko-fi.com/cdn/kofi3.png?v=3" height="50" width="210" alt="myconsciousness" />
    </a>
  </p>
</div>

You can also show on your repository that your app is made with **misskey** by using one of the following badges:

[![Powered by misskey](https://img.shields.io/badge/Powered%20by-misskey-00acee.svg)](https://github.com/misskey-dart/misskey)
[![Powered by misskey](https://img.shields.io/badge/Powered%20by-misskey-00acee.svg?style=flat-square)](https://github.com/misskey-dart/misskey)
[![Powered by misskey](https://img.shields.io/badge/Powered%20by-misskey-00acee.svg?style=for-the-badge)](https://github.com/misskey-dart/misskey)

```license
[![Powered by misskey](https://img.shields.io/badge/Powered%20by-misskey-00acee.svg)](https://github.com/misskey-dart/misskey)
[![Powered by misskey](https://img.shields.io/badge/Powered%20by-misskey-00acee.svg?style=flat-square)](https://github.com/misskey-dart/misskey)
[![Powered by misskey](https://img.shields.io/badge/Powered%20by-misskey-00acee.svg?style=for-the-badge)](https://github.com/misskey-dart/misskey)
```

## 1.8. License 🔑

All resources of **misskey** is provided under the `BSD-3` license.

```license
Copyright 2023 Kato Shinya. All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided the conditions.
```

> **Note**</br>
> License notices in the source are strictly validated based on `.github/header-checker-lint.yml`. Please check [header-checker-lint.yml](https://github.com/misskey-dart/misskey/tree/main/.github/header-checker-lint.yml) for the permitted standards.

## 1.9. More Information 🧐

**misskey** was designed and implemented by **_Kato Shinya ([@myConsciousness](https://github.com/myConsciousness))_**.

- [Creator Profile](https://github.com/myConsciousness)
- [License](https://github.com/misskey-dart/misskey/blob/main/LICENSE)
- [API Document](https://pub.dev/documentation/misskey/latest/misskey/misskey-library.html)
- [Release Note](https://github.com/misskey-dart/misskey/releases)
- [Bug Report](https://github.com/misskey-dart/misskey/issues)
