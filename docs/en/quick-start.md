# Quick Start

Follow the steps below to quickly get started with the `uni_links_desktop` plugin:

## Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  uni_links_desktop: ^0.2.0
```

Or

```yaml
dependencies:
  uni_links_desktop:
    git:
      url: https://github.com/leanflutter/uni_links_desktop.git
      ref: main
```

## Usage

```dart
import 'package:uni_links_desktop/uni_links_desktop.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    registerProtocol('unilinks');
  }

  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

```

> Just add these extra steps, see [uni_links](https://github.com/avioli/uni_links/tree/master/uni_links) for other usage

#### macOS

Change the file `macos/Runner/Info.plist` as follows:

```diff
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIconFile</key>
	<string></string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>$(PRODUCT_NAME)</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>$(FLUTTER_BUILD_NAME)</string>
	<key>CFBundleVersion</key>
	<string>$(FLUTTER_BUILD_NUMBER)</string>
	<key>LSMinimumSystemVersion</key>
	<string>$(MACOSX_DEPLOYMENT_TARGET)</string>
	<key>NSHumanReadableCopyright</key>
	<string>$(PRODUCT_COPYRIGHT)</string>
	<key>NSMainNibFile</key>
	<string>MainMenu</string>
+	<key>CFBundleURLTypes</key>
+	<array>
+		<dict>
+			<key>CFBundleTypeRole</key>
+			<string>Editor</string>
+			<key>CFBundleURLName</key>
+			<string></string>
+			<key>CFBundleURLSchemes</key>
+			<array>
+				<string>unilinks</string>
+			</array>
+		</dict>
+	</array>
	<key>NSPrincipalClass</key>
	<string>NSApplication</string>
</dict>
</plist>
```

#### Windows

Change the file `windows/runner/main.cpp` as follows:

```diff
#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

+#include <uni_links_desktop/uni_links_desktop_plugin.h>

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
+  // Replace uni_links_desktop_example with your_window_title.
+  HWND hwnd = ::FindWindow(L"FLUTTER_RUNNER_WIN32_WINDOW", L"uni_links_desktop_example");
+  if (hwnd != NULL) {
+    DispatchToUniLinksDesktop(hwnd);
+
+    ::ShowWindow(hwnd, SW_NORMAL);
+    ::SetForegroundWindow(hwnd);
+    return EXIT_FAILURE;
+  }

  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.CreateAndShow(L"uni_links_desktop_example", origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
```

If you use `MSIX` to package your application, you need to add `protocol_activation` configuration in `msix_config`:

```yaml
msix_config:
  protocol_activation: myprotocol
```

> See this issue for details: [YehudaKremer/msix#187](https://github.com/YehudaKremer/msix/issues/187)

> Please see the [example app](https://github.com/leanflutter/uni_links_desktop/tree/main/example) of this plugin for a full example.
