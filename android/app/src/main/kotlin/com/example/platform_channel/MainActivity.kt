package com.example.platform_channel

import android.content.Context
import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.localstorage"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "storeData" -> {
                    // Get the value from the Flutter method
                    val value = call.argument<String>("value")
                    // Get the SharedPreferences editor
                    val sharedPref = getSharedPreferences("FlutterSharedPref", Context.MODE_PRIVATE)
                    with(sharedPref.edit()) {
                        putString("key", value)
                        apply()  // Save the value persistently
                    }
                    result.success(null)
                }
                "retrieveData" -> {
                    // Retrieve the value from SharedPreferences
                    val sharedPref = getSharedPreferences("FlutterSharedPref", Context.MODE_PRIVATE)
                    val storedValue = sharedPref.getString("key", "No value stored")
                    result.success(storedValue)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)

    }
}

