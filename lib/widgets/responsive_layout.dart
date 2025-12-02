import 'package:flutter/material.dart';

import '../utils/screen_size.dart';

/// Adaptive layout that builds different widgets based on screen size
class AdaptiveLayout extends StatelessWidget {
  /// Widget for extra extra small screens (< 375)
  final Widget? xxs;

  /// Widget for extra small screens (< 575)
  final Widget? xs;

  /// Widget for small screens (576-767)
  final Widget? sm;

  /// Widget for medium screens (768-991)
  final Widget? md;

  /// Widget for large screens (992-1199)
  final Widget? lg;

  /// Widget for extra large screens (>= 1200)
  final Widget? xl;

  /// Default widget if no matching screen size widget is provided
  final Widget? defaultWidget;

  /// Whether to use the nearest smaller screen size widget as fallback
  final bool useNearestFallback;

  const AdaptiveLayout({
    super.key,
    this.xxs,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.defaultWidget,
    this.useNearestFallback = true,
  });

  /// Simplified constructor for mobile/tablet/desktop layouts
  const AdaptiveLayout.mobileTabletDesktop({
    super.key,
    Widget? mobile,
    Widget? tablet,
    Widget? desktop,
    this.defaultWidget,
  }) : xxs = mobile,
       xs = mobile,
       sm = tablet,
       md = tablet,
       lg = desktop,
       xl = desktop,
       useNearestFallback = true;

  /// Simplified constructor for mobile/desktop layouts
  const AdaptiveLayout.mobileDesktop({super.key, Widget? mobile, Widget? desktop, this.defaultWidget})
    : xxs = mobile,
      xs = mobile,
      sm = mobile,
      md = desktop,
      lg = desktop,
      xl = desktop,
      useNearestFallback = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final screenSize = ScreenSize.forWidth(size.width);

    if (screenSize == null) {
      return defaultWidget ?? const SizedBox.shrink();
    }

    final widget = _getWidgetForScreenSize(screenSize);

    if (widget != null) {
      return widget;
    }

    return defaultWidget ?? const SizedBox.shrink();
  }

  Widget? _getWidgetForScreenSize(ScreenSize screenSize) {
    switch (screenSize) {
      case ScreenSize.xxs:
        if (xxs != null) return xxs;
        if (useNearestFallback) return xs ?? sm ?? md ?? lg ?? xl;
        break;
      case ScreenSize.xs:
        if (xs != null) return xs;
        if (useNearestFallback) return xxs ?? sm ?? md ?? lg ?? xl;
        break;
      case ScreenSize.sm:
        if (sm != null) return sm;
        if (useNearestFallback) return xs ?? xxs ?? md ?? lg ?? xl;
        break;
      case ScreenSize.md:
        if (md != null) return md;
        if (useNearestFallback) return sm ?? lg ?? xs ?? xxs ?? xl;
        break;
      case ScreenSize.lg:
        if (lg != null) return lg;
        if (useNearestFallback) return xl ?? md ?? sm ?? xs ?? xxs;
        break;
      case ScreenSize.xl:
        if (xl != null) return xl;
        if (useNearestFallback) return lg ?? md ?? sm ?? xs ?? xxs;
        break;
    }
    return null;
  }
}

/// Builder that provides current screen size information
class ResponsiveBuilder extends StatelessWidget {
  /// Builder function that receives screen size information
  final Widget Function(BuildContext context, ScreenSize screenSize, Size size) builder;

  /// Optional breakpoint configuration
  final ResponsiveBreakpoints? breakpoints;

  const ResponsiveBuilder({super.key, required this.builder, this.breakpoints});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final screenSize = ScreenSize.forWidth(size.width) ?? ScreenSize.xs;

    return builder(context, screenSize, size);
  }
}

/// Configuration for custom breakpoints
class ResponsiveBreakpoints {
  final double mobile;
  final double tablet;
  final double desktop;

  const ResponsiveBreakpoints({this.mobile = 600, this.tablet = 900, this.desktop = 1200});

  bool isMobile(double width) => width < mobile;
  bool isTablet(double width) => width >= mobile && width < desktop;
  bool isDesktop(double width) => width >= desktop;
}

/// Value builder that returns different values based on screen size
class ResponsiveValue<T> extends StatelessWidget {
  /// Value for extra extra small screens
  final T? xxs;

  /// Value for extra small screens
  final T? xs;

  /// Value for small screens
  final T? sm;

  /// Value for medium screens
  final T? md;

  /// Value for large screens
  final T? lg;

  /// Value for extra large screens
  final T? xl;

  /// Default value if no matching screen size value is provided
  final T defaultValue;

  /// Builder function that uses the resolved value
  final Widget Function(BuildContext context, T value) builder;

  /// Whether to use the nearest smaller screen size value as fallback
  final bool useNearestFallback;

  const ResponsiveValue({
    super.key,
    this.xxs,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    required this.defaultValue,
    required this.builder,
    this.useNearestFallback = true,
  });

  /// Simplified constructor for mobile/tablet/desktop values
  const ResponsiveValue.mobileTabletDesktop({
    super.key,
    T? mobile,
    T? tablet,
    T? desktop,
    required this.defaultValue,
    required this.builder,
  }) : xxs = mobile,
       xs = mobile,
       sm = tablet,
       md = tablet,
       lg = desktop,
       xl = desktop,
       useNearestFallback = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final screenSize = ScreenSize.forWidth(size.width);

    if (screenSize == null) {
      return builder(context, defaultValue);
    }

    final value = _getValueForScreenSize(screenSize) ?? defaultValue;
    return builder(context, value);
  }

  T? _getValueForScreenSize(ScreenSize screenSize) {
    switch (screenSize) {
      case ScreenSize.xxs:
        if (xxs != null) return xxs;
        if (useNearestFallback) return xs ?? sm ?? md ?? lg ?? xl;
        break;
      case ScreenSize.xs:
        if (xs != null) return xs;
        if (useNearestFallback) return xxs ?? sm ?? md ?? lg ?? xl;
        break;
      case ScreenSize.sm:
        if (sm != null) return sm;
        if (useNearestFallback) return xs ?? xxs ?? md ?? lg ?? xl;
        break;
      case ScreenSize.md:
        if (md != null) return md;
        if (useNearestFallback) return sm ?? lg ?? xs ?? xxs ?? xl;
        break;
      case ScreenSize.lg:
        if (lg != null) return lg;
        if (useNearestFallback) return xl ?? md ?? sm ?? xs ?? xxs;
        break;
      case ScreenSize.xl:
        if (xl != null) return xl;
        if (useNearestFallback) return lg ?? md ?? sm ?? xs ?? xxs;
        break;
    }
    return null;
  }

  /// Static helper to get a value without using a widget
  static T getValue<T>(
    BuildContext context, {
    T? xxs,
    T? xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    required T defaultValue,
    bool useNearestFallback = true,
  }) {
    final size = MediaQuery.sizeOf(context);
    final screenSize = ScreenSize.forWidth(size.width);

    if (screenSize == null) return defaultValue;

    T? getValue(ScreenSize size) {
      switch (size) {
        case ScreenSize.xxs:
          if (xxs != null) return xxs;
          if (useNearestFallback) return xs ?? sm ?? md ?? lg ?? xl;
        case ScreenSize.xs:
          if (xs != null) return xs;
          if (useNearestFallback) return xxs ?? sm ?? md ?? lg ?? xl;
        case ScreenSize.sm:
          if (sm != null) return sm;
          if (useNearestFallback) return xs ?? xxs ?? md ?? lg ?? xl;
        case ScreenSize.md:
          if (md != null) return md;
          if (useNearestFallback) return sm ?? lg ?? xs ?? xxs ?? xl;
        case ScreenSize.lg:
          if (lg != null) return lg;
          if (useNearestFallback) return xl ?? md ?? sm ?? xs ?? xxs;
        case ScreenSize.xl:
          if (xl != null) return xl;
          if (useNearestFallback) return lg ?? md ?? sm ?? xs ?? xxs;
      }
      return null;
    }

    return getValue(screenSize) ?? defaultValue;
  }
}

/// Grid builder that adapts columns based on screen size
class ResponsiveGrid extends StatelessWidget {
  /// Number of columns for each screen size
  final int? xxsColumns;
  final int? xsColumns;
  final int? smColumns;
  final int? mdColumns;
  final int? lgColumns;
  final int? xlColumns;

  /// Default number of columns
  final int defaultColumns;

  /// Children widgets
  final List<Widget> children;

  /// Spacing between items
  final double spacing;

  /// Aspect ratio of grid items
  final double aspectRatio;

  /// Padding around the grid
  final EdgeInsets? padding;

  const ResponsiveGrid({
    super.key,
    this.xxsColumns,
    this.xsColumns,
    this.smColumns,
    this.mdColumns,
    this.lgColumns,
    this.xlColumns,
    this.defaultColumns = 2,
    required this.children,
    this.spacing = 16.0,
    this.aspectRatio = 1.0,
    this.padding,
  });

  /// Simplified constructor for mobile/tablet/desktop grids
  const ResponsiveGrid.mobileTabletDesktop({
    super.key,
    int? mobileColumns,
    int? tabletColumns,
    int? desktopColumns,
    this.defaultColumns = 2,
    required this.children,
    this.spacing = 16.0,
    this.aspectRatio = 1.0,
    this.padding,
  }) : xxsColumns = mobileColumns,
       xsColumns = mobileColumns,
       smColumns = tabletColumns,
       mdColumns = tabletColumns,
       lgColumns = desktopColumns,
       xlColumns = desktopColumns;

  @override
  Widget build(BuildContext context) {
    return ResponsiveValue<int>(
      xxs: xxsColumns,
      xs: xsColumns,
      sm: smColumns,
      md: mdColumns,
      lg: lgColumns,
      xl: xlColumns,
      defaultValue: defaultColumns,
      builder: (context, columns) {
        return Padding(
          padding: padding ?? EdgeInsets.zero,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              childAspectRatio: aspectRatio,
            ),
            itemCount: children.length,
            itemBuilder: (context, index) => children[index],
          ),
        );
      },
    );
  }
}

/// Helper extensions for context
extension ResponsiveContextExtensions on BuildContext {
  /// Get current screen size
  ScreenSize get screenSize => ScreenSize.forWidth(MediaQuery.sizeOf(this).width) ?? ScreenSize.xs;

  /// Check if current screen is mobile
  bool get isMobile => screenSize == ScreenSize.xxs || screenSize == ScreenSize.xs;

  /// Check if current screen is tablet
  bool get isTablet => screenSize == ScreenSize.sm || screenSize == ScreenSize.md;

  /// Check if current screen is desktop
  bool get isDesktop => screenSize == ScreenSize.lg || screenSize == ScreenSize.xl;

  /// Get responsive value
  T responsiveValue<T>({T? xxs, T? xs, T? sm, T? md, T? lg, T? xl, required T defaultValue}) {
    return ResponsiveValue.getValue(this, xxs: xxs, xs: xs, sm: sm, md: md, lg: lg, xl: xl, defaultValue: defaultValue);
  }
}
