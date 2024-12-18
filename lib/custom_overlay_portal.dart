import 'dart:ui';

import 'package:flutter/material.dart';

enum CustomOverlayEntryDirection { top, bottom, left, right }

/// A controller for managing the state of a custom overlay portal.
///
/// This class extends [ChangeNotifier] to allow listeners to be notified
/// when the state changes.
class CustomOverLayPortalController extends ChangeNotifier {
  /// Creates a new instance of [CustomOverLayPortalController].
  CustomOverLayPortalController();

  /// Indicates whether the overlay is currently being shown.
  bool isShowing = false;

  /// Indicates whether the overlay has been permanently closed.
  bool isClosed = false;

  /// Shows the overlay and notifies listeners of the change.
  void show() {
    isShowing = true;
    notifyListeners();
  }

  /// Hides the overlay and notifies listeners of the change.
  void hide() {
    isShowing = false;
    notifyListeners();
  }

  /// Closes the overlay, marks it as permanently closed, and notifies listeners.
  void close() {
    isShowing = false;
    isClosed = true;
    notifyListeners();
  }

  /// Resets the closed state of the overlay, allowing it to be shown again.
  void reset() {
    isClosed = false;
  }
}

class CustomOverlayPortal extends StatefulWidget {
  const CustomOverlayPortal({
    required this.child,
    required this.popUpContent,
    required this.controller,
    this.margin = EdgeInsets.zero,
    this.alignment = Alignment.center,
    this.entryDirection = CustomOverlayEntryDirection.top,
    super.key,
  });
  final Widget child;
  final Widget popUpContent;
  final CustomOverLayPortalController controller;
  final Alignment alignment;
  final EdgeInsets margin;
  final CustomOverlayEntryDirection entryDirection;
  @override
  State<CustomOverlayPortal> createState() => _CustomOverlayPortalState();
}

class _CustomOverlayPortalState extends State<CustomOverlayPortal> {
  final overlayPortalController = OverlayPortalController();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  void _listener() {
    if (widget.controller.isShowing) {
      overlayPortalController.show();
    } else if (widget.controller.isClosed) {
      overlayPortalController.hide();
      widget.controller.reset();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: overlayPortalController,
      overlayChildBuilder: (context) {
        return CustomOverlayWrapper(
          margin: widget.margin,
          alignment: widget.alignment,
          controller: widget.controller,
          onDismiss: widget.controller.close,
          entryDirection: widget.entryDirection,
          child: widget.popUpContent,
        );
      },
      child: widget.child,
    );
  }
}

class CustomOverlayWrapper extends StatefulWidget {
  const CustomOverlayWrapper({
    required this.child,
    required this.onDismiss,
    required this.controller,
    required this.margin,
    required this.entryDirection,
    this.alignment = Alignment.center,
    super.key,
  });
  final Widget child;
  final VoidCallback onDismiss;
  final CustomOverLayPortalController controller;
  final Alignment alignment;
  final EdgeInsets margin;
  final CustomOverlayEntryDirection entryDirection;
  @override
  State<CustomOverlayWrapper> createState() => _CustomOverlayWrapperState();
}

class _CustomOverlayWrapperState extends State<CustomOverlayWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animatePosition;
  late Animation<double> _animateFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animatePosition = Tween<Offset>(
      begin: switch (widget.entryDirection) {
        CustomOverlayEntryDirection.top => const Offset(0, -1),
        CustomOverlayEntryDirection.bottom => const Offset(0, 1),
        CustomOverlayEntryDirection.left => const Offset(-1, 0),
        CustomOverlayEntryDirection.right => const Offset(1, 0),
      },
      end: Offset.zero, // End in the center
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _animateFade = Tween<double>(begin: 0, end: 0.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    widget.controller.addListener(_customOverlayListener);
    _controller
      ..forward()
      ..addListener(_listener);
  }

  void _customOverlayListener() {
    if (!widget.controller.isShowing) {
      _dismiss();
    }
  }

  void _listener() {
    if (_controller.isDismissed) {
      widget.onDismiss();
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_listener)
      ..dispose();
    widget.controller.removeListener(_customOverlayListener);
    super.dispose();
  }

  void _dismiss() {
    if (_controller.isAnimating || _controller.isDismissed) {
      return;
    }
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _dismiss,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AnimatedBuilder(
              animation: _animateFade,
              builder: (context, child) {
                return Container(
                  color: Color.fromRGBO(0, 0, 0, _animateFade.value),
                );
              },
            ),
          ),
        ),
        Container(
          margin: widget.margin,
          child: AnimatedBuilder(
            animation: _animatePosition,
            builder: (context, child) {
              return FractionalTranslation(
                translation: _animatePosition.value,
                child: Align(
                  alignment: widget.alignment,
                  child: Material(
                    // Wrap with Material for elevation
                    elevation: 8, // Add a subtle elevation
                    borderRadius:
                        BorderRadius.circular(8), // Add rounded corners
                    child: ConstrainedBox(
                      // Constrain the size
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: child,
                    ),
                  ),
                ),
              );
            },
            child: widget.child, // Move child here
          ),
        ),
      ],
    );
  }
}
