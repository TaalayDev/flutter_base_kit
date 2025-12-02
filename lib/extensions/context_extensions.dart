import 'dart:ui';

import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  // Theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  // MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get width => screenSize.width;
  double get height => screenSize.height;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;

  // Responsive helpers
  bool get isSmallScreen => width < 600;
  bool get isMediumScreen => width >= 600 && width < 1024;
  bool get isLargeScreen => width >= 1024;
  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;

  // Orientation
  Orientation get orientation => mediaQuery.orientation;
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  // Platform
  TargetPlatform get platform => theme.platform;
  bool get isIOS => platform == TargetPlatform.iOS;
  bool get isAndroid => platform == TargetPlatform.android;
  bool get isMacOS => platform == TargetPlatform.macOS;
  bool get isWindows => platform == TargetPlatform.windows;
  bool get isLinux => platform == TargetPlatform.linux;
  bool get isFuchsia => platform == TargetPlatform.fuchsia;

  // Focus
  FocusScopeNode get focusScope => FocusScope.of(this);
  void unfocus() => focusScope.unfocus();
  void requestFocus([FocusNode? node]) => FocusScope.of(this).requestFocus(node ?? FocusNode());

  // Scaffold
  ScaffoldState get scaffold => Scaffold.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  // SnackBar helpers
  void showSnackBar(String message, {Duration duration = const Duration(seconds: 3), SnackBarAction? action}) {
    scaffoldMessenger.showSnackBar(SnackBar(content: Text(message), duration: duration, action: action));
  }

  void showErrorSnackBar(String message) {
    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text(message), backgroundColor: colorScheme.error, duration: const Duration(seconds: 4)),
    );
  }

  void showSuccessSnackBar(String message) {
    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green, duration: const Duration(seconds: 3)),
    );
  }

  // Navigation helpers
  Future<T?> push<T>(Widget page) {
    return navigator.push<T>(MaterialPageRoute(builder: (_) => page));
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return navigator.pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> pushReplacement<T, TO>(Widget page) {
    return navigator.pushReplacement<T, TO>(MaterialPageRoute(builder: (_) => page));
  }

  void pop<T>([T? result]) => navigator.pop(result);

  void popUntil(RoutePredicate predicate) => navigator.popUntil(predicate);

  void popToRoot() => navigator.popUntil((route) => route.isFirst);

  // Modal helpers
  Future<T?> showBottomSheet<T>({
    required Widget Function(BuildContext) builder,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      builder: builder,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }

  Future<T?> showDialogBox<T>({required Widget Function(BuildContext) builder, bool barrierDismissible = true}) {
    return showDialog<T>(context: this, builder: builder, barrierDismissible: barrierDismissible);
  }

  // Padding helpers
  double get statusBarHeight => padding.top;
  double get bottomBarHeight => padding.bottom;
  double get keyboardHeight => viewInsets.bottom;
  bool get isKeyboardOpen => keyboardHeight > 0;

  // Safe area helpers
  EdgeInsets get safeAreaPadding => viewPadding;
  double get safeAreaTop => safeAreaPadding.top;
  double get safeAreaBottom => safeAreaPadding.bottom;

  // Text scale
  double get textScaleFactor => mediaQuery.textScaleFactor;

  // Brightness
  Brightness get brightness => theme.brightness;
  bool get isDarkMode => brightness == Brightness.dark;
  bool get isLightMode => brightness == Brightness.light;
}
