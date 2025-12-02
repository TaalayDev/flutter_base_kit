import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:anchor_scroll_controller/anchor_scroll_controller.dart';

/// A customizable horizontal scrolling list with animations.
///
/// This widget creates a horizontal scrollable list with title, items, and optional
/// "see all" button. Items appear with staggered animations when first displayed.
/// Uses scroll_to_index package for efficient auto-scrolling functionality.
class HorizontalScroller<T> extends StatefulWidget {
  /// Title displayed above the list
  final String? title;

  /// List of items to display
  final List<T> items;

  /// Builder function for each item
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Optional callback for the "See All" button
  final VoidCallback? onSeeAllPressed;

  /// Text for the "See All" button
  final String? seeAllText;

  /// Whether the list is currently loading
  final bool isLoading;

  /// Number of shimmer loading placeholders to show
  final int loadingItemCount;

  /// Builder function for loading placeholders
  final Widget Function(BuildContext context, int index)? loadingBuilder;

  /// Height of the scrollable list
  final double height;

  /// Spacing between items
  final double spacing;

  /// Padding around the list
  final EdgeInsetsGeometry padding;

  /// Whether to show fading edges on the scrollable list
  final bool showFadingEdges;

  /// Empty widget when no items are present
  final Widget emptyWidget;

  /// Whether to automatically scroll the list
  final bool isAutoScroll;

  /// Duration between auto-scrolls
  final Duration autoScrollDuration;

  /// Duration of the scroll animation
  final Duration autoScrollAnimationDuration;

  /// Preferred position to scroll to (0.0 to 1.0)
  final double preferPosition;

  const HorizontalScroller({
    super.key,
    this.title,
    required this.items,
    required this.itemBuilder,
    this.onSeeAllPressed,
    this.seeAllText,
    this.isLoading = false,
    this.loadingItemCount = 3,
    this.loadingBuilder,
    this.height = 180,
    this.spacing = 12,
    this.padding = EdgeInsets.zero,
    this.showFadingEdges = true,
    this.emptyWidget = const SizedBox(),
    this.isAutoScroll = false,
    this.autoScrollDuration = const Duration(seconds: 3),
    this.autoScrollAnimationDuration = const Duration(milliseconds: 500),
    this.preferPosition = 0.5, // Default to center
  });

  @override
  State<HorizontalScroller<T>> createState() => _HorizontalScrollerState<T>();
}

class _HorizontalScrollerState<T> extends State<HorizontalScroller<T>> {
  late AnchorScrollController _scrollController;
  Timer? _autoScrollTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = AnchorScrollController(
      initialScrollOffset: widget.preferPosition * widget.height,
      onIndexChanged: (index, userScroll) {
        if (userScroll) {
          _currentIndex = index;
        }
      },
    );

    if (widget.isAutoScroll) {
      _startAutoScroll();
    }
  }

  @override
  void didUpdateWidget(HorizontalScroller<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle change in auto-scroll setting
    if (widget.isAutoScroll != oldWidget.isAutoScroll || !listEquals(widget.items, oldWidget.items)) {
      if (widget.isAutoScroll) {
        _startAutoScroll();
      } else {
        _stopAutoScroll();
      }
    }
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();

    // Don't start scrolling if there aren't enough items
    if (widget.items.length <= 1) return;

    _autoScrollTimer = Timer.periodic(widget.autoScrollDuration, (_) {
      if (!mounted || widget.items.isEmpty) {
        return;
      }

      _currentIndex = (_currentIndex + 1) % widget.items.length;

      // Scroll to the next index
      _scrollController.scrollToIndex(
        index: _currentIndex,
        curve: _currentIndex != 0 ? Curves.easeInOut : Curves.linear,
        scrollSpeed: 0.75,
      );
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    final hasTitle = widget.title != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasTitle) ...[
          Padding(
            padding: EdgeInsets.only(
              left: widget.padding.horizontal / 2,
              right: widget.padding.horizontal / 2,
              top: 16,
              bottom: 12,
            ),
            child: Row(
              children: [
                Text(
                  widget.title!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (widget.onSeeAllPressed != null)
                  TextButton(
                    onPressed: widget.onSeeAllPressed,
                    child: Text(
                      widget.seeAllText ?? 'See all',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
              ],
            ),
          ),
        ],
        SizedBox(height: widget.height, child: _buildList(context)),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    if (widget.isLoading) {
      return _buildLoadingList(context);
    }

    if (widget.items.isEmpty) {
      return widget.emptyWidget;
    }

    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    Widget listView = ListView.separated(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: widget.padding,
      itemCount: widget.items.length,
      separatorBuilder: (context, index) => SizedBox(width: widget.spacing),
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return AnchorItemWrapper(
          key: ValueKey(index),
          controller: _scrollController,
          index: index,
          child: widget
              .itemBuilder(context, item, index)
              .animate()
              .fadeIn(duration: 300.ms, delay: (50 * index).ms)
              .slideX(
                begin: 0.2,
                end: 0,
                duration: 300.ms,
                delay: (50 * index).ms,
                curve: Curves.easeOutQuad,
              ),
        );
      },
    );

    if (widget.showFadingEdges) {
      return ShaderMask(
        shaderCallback: (Rect rect) {
          return const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.black,
              Colors.transparent,
              Colors.transparent,
              Colors.black,
            ],
            stops: [0.0, 0.05, 0.95, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: listView,
      );
    }

    return listView;
  }

  Widget _buildLoadingList(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: widget.padding,
      itemCount: widget.loadingItemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            right: index == widget.loadingItemCount - 1 ? 0 : widget.spacing,
          ),
          child: widget.loadingBuilder != null
              ? widget.loadingBuilder!(context, index)
              : Container(
                  width: 150,
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
        );
      },
    );
  }
}
