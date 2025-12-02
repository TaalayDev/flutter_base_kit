#include "include/flutter_base_kit/flutter_base_kit_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_base_kit_plugin.h"

void FlutterBaseKitPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_base_kit::FlutterBaseKitPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
