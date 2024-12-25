package com.shivalay.cinemagicx

import io.flutter.embedding.android.FlutterActivity

import android.os.Bundle
import android.view.WindowManager

class MainActivity: FlutterActivity() {
      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        
        // This will prevent screenshots and screen recording
        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)


    }
}
