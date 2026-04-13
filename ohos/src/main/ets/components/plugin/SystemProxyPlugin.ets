/*
 * Copyright (C) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the 'License');
 
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import {
  FlutterPlugin,
  FlutterPluginBinding,
  Log,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';
import connection from '@ohos.net.connection';

const TAG = 'SystemProxyPlugin';

/** SystemProxyPlugin **/
export default class SystemProxyPlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;

  getUniqueClassName(): string {
    return 'SystemProxyPlugin';
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), 'system_proxy');
    this.channel.setMethodCallHandler(this);
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null);
    }
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (call.method == 'getProxySettings') {
      this.getProxySettings(result);
    } else {
      result.notImplemented();
    }
  }

  private async getProxySettings(result: MethodResult): Promise<void> {
    try {
      const proxy: connection.HttpProxy = await connection.getDefaultHttpProxy();
      if (proxy.host.length > 0) {
        result.success({
          host: proxy.host,
          port: `${proxy.port}`,
        });
        return;
      }
      result.success(null);
    } catch (error) {
      const message = this.errorMessage(error);
      Log.e(TAG, `getProxySettings error ${message}`);
      result.error('SYSTEM_PROXY_ERROR', message, null);
    }
  }

  private errorMessage(error: Object): string {
    if (error instanceof Error) {
      return error.message;
    }
    return `${error}`;
  }
}
