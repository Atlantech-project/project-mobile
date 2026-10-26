package io.atlantech.mobile

import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Device id for the API (ClientInfo in lib/core/network/client_info.dart).
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "io.atlantech.mobile/device")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getDeviceId" -> result.success(
                        Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID),
                    )
                    else -> result.notImplemented()
                }
            }
    }
}
