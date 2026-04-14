# system_proxy OpenHarmony README

## 1. 简介

system_proxy 是一个 Flutter 插件，用于读取系统代理配置，便于为 Dart HttpClient 配置代理，从而支持抓包、联调和测试等场景。

## 2. OpenHarmony 适配范围

当前 OpenHarmony 侧已适配以下能力：

- 读取系统手动代理配置
- 在 Flutter 层返回 host 和 port
- 在 example 工程中展示代理读取结果


## 3. API

| Name | Description | Type | Input | Output | ohos Support |
|------|-------------|------|-------|--------|--------------|
| getProxySettings | 读取系统代理配置 | function | 无 | `Map<String, String>?`，无代理时返回 `null` | yes |

返回结果说明：

- 手动代理：`{ host: xxx, port: yyy }`
- 无代理：`null`

## 4. 最简单的调用方式

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

## 5. 约束条件

1. Flutter: 3.7.12-ohos-1.0.6; SDK: 5.0.2(14); IDE: DevEco Studio 6.0.2.642; ROM: 6.0.0.130 SP25。
2. Flutter: 3.22.1-ohos-1.0.3; SDK: 5.0.2(14); IDE: DevEco Studio 6.0.2.642; ROM: 6.0.0.130 SP25。
3. Flutter: oh-3.27.4-dev; SDK: 5.0.2(14); IDE: DevEco Studio 6.0.2.642; ROM: 6.0.0.130 SP25。
4. Flutter: 3.35.8-ohos-0.0.1; SDK: 6.0.1(21); IDE: DevEco Studio 6.0.2.642; ROM: 6.0.0.130 SP25。

## 6. 使用说明

1. 在 Flutter 工程中引入 `system_proxy`。
2. 在 OpenHarmony 设备中连接 Wi-Fi。
3. 在 Wi-Fi 详情页中配置手动代理。
4. 启动 example 应用或业务应用，调用 `SystemProxy.getProxySettings()`。
5. 根据返回的 `host` 和 `port` 配置 Dart HttpClient 代理。


## 7. 开源协议

本项目沿用 BSD-3-Clause 风格协议，详见 [LICENSE](LICENSE)。

## 8. 已知限制

1. OpenHarmony 当前版本仅支持手动代理读取。
2. 自动代理/PAC 不作为当前正式支持能力。
3. example 页面当前主要用于验证 `host:port` 和 `no proxy` 两类结果。