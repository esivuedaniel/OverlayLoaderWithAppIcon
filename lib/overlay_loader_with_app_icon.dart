library overlay_loader_with_app_icon;
import 'package:flutter/material.dart';


/// Inspired by https://pub.dev/packages/loading_overlay package
///
/// Wrapper [OverlayLoaderWithAppIcon] around any widget that makes an async call to show a modal with [appIcon] progress
/// indicator while the async call is in progress.
///
/// The progress indicator can be turned on or off using [isLoading]
///
/// The progress indicator defaults to a [CircularProgressIndicator] with [appIcon] inbetween,
/// the [appIcon] can be of any kind of widget
///
/// The appIcon size can be increased using [appIconSize]
/// The color of the modal barrier can be set using [overlayBackgroundColor]
///
/// The opacity of the modal barrier can be set using [overlayOpacity]
///
///The border radius of the container can be increased using[borderRadius]

class OverlayLoaderWithAppIcon extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final Widget appIcon;
  final double appIconSize;
  final double borderRadius;
  final double overlayOpacity;
  final Color? overlayBackgroundColor;
  final Color ?circularProgressColor;


  OverlayLoaderWithAppIcon({required this.isLoading, required this.child, required this.appIcon, this.appIconSize=50,
    this.borderRadius=15, this.overlayOpacity=0.5, this.circularProgressColor, this.overlayBackgroundColor});
  @override
  Widget build(BuildContext context) {
    return OverLayAnimation(
      isLoading: isLoading,
      opacity: overlayOpacity,
      color: overlayBackgroundColor??Theme.of(context).colorScheme.background,
      progressIndicator: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding:  EdgeInsets.all(20),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: CircularProgressIndicator(
                  color:circularProgressColor??Theme.of(context).colorScheme.background,
                  strokeWidth: 2,
                ),
              ),
              SizedBox(
                width: appIconSize,
                height: appIconSize,
                child: appIcon,
              ),
            ],
          ),
        ),
      ),//Change this loading overlay
      child: child,
    );
  }
}


//OverLayAnimation class for ModalBarrier
class OverLayAnimation extends StatefulWidget {

  final bool isLoading;
  final double opacity;
  final Color? color;
  final Widget progressIndicator;
  final Widget child;

  OverLayAnimation({
    required this.isLoading,
    required this.child,
    this.opacity = 0.5,
    this.progressIndicator = const CircularProgressIndicator(),
    this.color,
  });

  @override
  State<OverLayAnimation> createState() => _OverLayAnimationState();
}

class _OverLayAnimationState extends State<OverLayAnimation> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  bool? _overlayVisible;

  _OverLayAnimationState();

  @override
  void initState() {
    super.initState();
    _overlayVisible = false;
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      status == AnimationStatus.forward ? setState(() => {_overlayVisible = true}) : null;
      status == AnimationStatus.dismissed ? setState(() => {_overlayVisible = false}) : null;
    });
    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(OverLayAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    widgets.add(widget.child);

    if (_overlayVisible == true) {
      final modal = FadeTransition(
        opacity: _animation,
        child: Stack(
          children: <Widget>[
            Opacity(
              child: ModalBarrier(
                dismissible: false,
                color: widget.color ?? Theme.of(context).colorScheme.background,
              ),
              opacity: widget.opacity,
            ),
            Center(child: widget.progressIndicator),
          ],
        ),
      );
      widgets.add(modal);
    }

    return Stack(children: widgets);
  }
}