package com.tally.app;

import android.os.Build;
import android.os.Bundle;
import android.window.SplashScreenView;

import androidx.core.view.WindowCompat;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        WindowCompat.setDecorFitsSystemWindows(getWindow(), false);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            getSplashScreen()
                    .setOnExitAnimationListener(
                            SplashScreenView::remove);
        }

        super.onCreate(savedInstanceState);
    }
}
