package com.capgemini.wayat

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.view.FlutterMain
import android.os.Build;
import android.view.WindowManager
import android.util.Log;
import com.google.android.gms.maps.MapsInitializer
import com.google.android.gms.maps.MapsInitializer.Renderer
import com.google.android.gms.maps.OnMapsSdkInitializedCallback

class MainActivity: FlutterActivity(), OnMapsSdkInitializedCallback {
    override fun onCreate(savedInstanceState: Bundle?){
        super.onCreate(savedInstanceState);
        MapsInitializer.initialize(applicationContext, Renderer.LATEST, this)
    }

    override fun onMapsSdkInitialized(renderer: MapsInitializer.Renderer) {
      when (renderer) {
        Renderer.LATEST -> Log.d("NewRendererLog", "The latest version of the renderer is used.")
        Renderer.LEGACY -> Log.d("NewRendererLog","The legacy version of the renderer is used.")
      }
    }
}
