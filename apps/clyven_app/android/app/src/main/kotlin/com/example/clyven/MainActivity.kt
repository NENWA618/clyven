package com.example.clyven

import android.app.PictureInPictureParams
import android.content.res.Configuration
import android.os.Build
import android.util.Rational
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private var channel: MethodChannel? = null
    private var pipEligible = false
    private var aspect = Rational(16, 9)

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "clyven/pip")
        channel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "setEligible" -> {
                    pipEligible = call.argument<Boolean>("eligible") ?: false
                    val w = call.argument<Int>("width") ?: 16
                    val h = call.argument<Int>("height") ?: 9
                    aspect = clampAspect(w, h)
                    updatePipParams()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    // Android only accepts aspect ratios between 1:2.39 and 2.39:1.
    private fun clampAspect(w: Int, h: Int): Rational {
        if (w <= 0 || h <= 0) return Rational(16, 9)
        val ratio = w.toDouble() / h
        return when {
            ratio > 2.39 -> Rational(239, 100)
            ratio < 1 / 2.39 -> Rational(100, 239)
            else -> Rational(w, h)
        }
    }

    private fun buildParams(): PictureInPictureParams? {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return null
        val builder = PictureInPictureParams.Builder().setAspectRatio(aspect)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            builder.setAutoEnterEnabled(pipEligible)
        }
        return builder.build()
    }

    private fun updatePipParams() {
        val params = buildParams() ?: return
        setPictureInPictureParams(params)
    }

    // Android 8-11: enter PiP when the user presses Home. Android 12+ uses autoEnter.
    override fun onUserLeaveHint() {
        super.onUserLeaveHint()
        if (pipEligible &&
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.O &&
            Build.VERSION.SDK_INT < Build.VERSION_CODES.S
        ) {
            val params = buildParams() ?: return
            enterPictureInPictureMode(params)
        }
    }

    override fun onPictureInPictureModeChanged(
        isInPictureInPictureMode: Boolean,
        newConfig: Configuration
    ) {
        super.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig)
        channel?.invokeMethod("pipChanged", isInPictureInPictureMode)
    }
}
