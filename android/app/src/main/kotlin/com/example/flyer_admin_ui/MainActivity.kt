package com.example.flyer_admin_ui

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import android.view.WindowManager

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.addFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS)
    }
}
