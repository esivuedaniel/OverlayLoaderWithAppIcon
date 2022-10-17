import 'package:flutter/material.dart';
import 'package:overlay_loader_with_app_icon/overlay_animation.dart';


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
