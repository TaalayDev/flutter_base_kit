import 'package:flutter/material.dart';

class LoadableButton extends StatelessWidget {
  final Widget title;
  final bool loading;
  final Color? buttonColor;
  final Function()? onPressed;
  final Size minimumSize;
  final Size maximumSize;
  final Color? titleColor;
  final double? indicatorSize;
  final BorderRadius? borderRadius;

  const LoadableButton({
    super.key,
    this.onPressed,
    this.loading = false,
    required this.title,
    this.buttonColor,
    this.minimumSize = const Size(double.infinity, 56),
    this.maximumSize = const Size(double.infinity, 56),
    this.titleColor,
    this.indicatorSize,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: ElevatedButton(
        key: ValueKey(loading),
        onPressed: loading ? null : onPressed,
        style: ButtonStyle(
          maximumSize: WidgetStatePropertyAll(maximumSize),
          minimumSize: WidgetStatePropertyAll(minimumSize),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 10),
          ),
          elevation: const WidgetStatePropertyAll(0.0),
          backgroundColor: WidgetStatePropertyAll(
            buttonColor ??
                (onPressed != null
                    ? Theme.of(context).primaryColor
                    : Colors.grey),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(15),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loading
                ? AnimatedOpacity(
                    opacity: loading ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: SizedBox(
                        width: indicatorSize ?? 20,
                        height: indicatorSize ?? 20,
                        child: const CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  )
                : DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: titleColor ?? Colors.white,
                      letterSpacing: -.3,
                    ),
                    child: title,
                  ),
          ],
        ),
      ),
    );
  }
}
