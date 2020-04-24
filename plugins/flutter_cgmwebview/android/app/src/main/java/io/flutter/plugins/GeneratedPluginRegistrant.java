package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.cgm.flutter.cgmwebview.FlutterCgmwebviewPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlutterCgmwebviewPlugin.registerWith(registry.registrarFor("com.cgm.flutter.cgmwebview.FlutterCgmwebviewPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
