#include <windows.h>

#ifndef FLUTTER_PLUGIN_UNI_LINKS_DESKTOP_PLUGIN_H_
#define FLUTTER_PLUGIN_UNI_LINKS_DESKTOP_PLUGIN_H_

#include <flutter_plugin_registrar.h>

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FLUTTER_PLUGIN_EXPORT __declspec(dllimport)
#endif

#if defined(__cplusplus)
extern "C" {
#endif

FLUTTER_PLUGIN_EXPORT void UniLinksDesktopPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar);

#define UNI_LINKS_DESKTOP_MSG_ID (WM_USER + 2)
FLUTTER_PLUGIN_EXPORT void DispatchToUniLinksDesktop(HWND hwnd);

#if defined(__cplusplus)
}  // extern "C"
#endif

#endif  // FLUTTER_PLUGIN_UNI_LINKS_DESKTOP_PLUGIN_H_
