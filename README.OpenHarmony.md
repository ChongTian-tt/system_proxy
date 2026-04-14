# system_proxy OpenHarmony README

## 1. Overview

system_proxy is a Flutter plugin used to read system proxy settings so that Dart HttpClient can work with proxy-based debugging, packet capture, and test scenarios.

## 2. OpenHarmony Scope

The current OpenHarmony adaptation covers the following capabilities:

- Read system manual proxy settings
- Return host and port to Flutter
- Display proxy results in the example application

## 3. API

| Name | Description | Type | Input | Output | ohos Support |
|------|-------------|------|-------|--------|--------------|
| getProxySettings | Read system proxy settings | function | none | `Map<String, String>?`, returns `null` when no proxy is configured | yes |

Return value details:

- Manual proxy: `{ host: xxx, port: yyy }`
- No proxy: `null`

## 4. Simplest Usage

```dart
import 'package:system_proxy/system_proxy.dart';

Future<void> readProxy() async {
  final proxy = await SystemProxy.getProxySettings();
  if (proxy == null) {
    print('no proxy');
    return;
  }
  print('proxy: ${proxy['host']}:${proxy['port']}');
}
```

## 5. Constraints

1. Flutter: 3.7.12-ohos-1.0.6; SDK: 5.0.2(14); IDE: DevEco Studio 6.0.2.642; ROM: 6.0.0.130 SP25。
2. Flutter: 3.22.1-ohos-1.0.3; SDK: 5.0.2(14); IDE: DevEco Studio 6.0.2.642; ROM: 6.0.0.130 SP25。
3. Flutter: oh-3.27.4-dev; SDK: 5.0.2(14); IDE: DevEco Studio 6.0.2.642; ROM: 6.0.0.130 SP25。
4. Flutter: 3.35.8-ohos-0.0.1; SDK: 6.0.1(21); IDE: DevEco Studio 6.0.2.642; ROM: 6.0.0.130 SP25。

## 6. Usage Notes

1. Add `system_proxy` to the Flutter project.
2. Connect the OpenHarmony device to Wi-Fi.
3. Configure a manual proxy in the Wi-Fi details page.
4. Launch the example app or your app and call `SystemProxy.getProxySettings()`.
5. Use the returned `host` and `port` to configure Dart HttpClient.

## 7. License

This project follows a BSD-3-Clause style license. See [LICENSE](LICENSE) for details.

## 8. Known Limitations

1. The current OpenHarmony implementation supports manual proxy reading only.
2. Automatic proxy/PAC is not included in the current supported feature set.
3. The example page is mainly used to verify `host:port` and `no proxy` results.