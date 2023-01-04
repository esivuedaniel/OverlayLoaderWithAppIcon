#  Overlay loader with app icon

A clean and light-weight package that shows a beautiful overlay loader with appIcon when initiating an async call.

## Demo App

![](https://media.giphy.com/media/9BIQDd4QuHEWihTuEz/giphy.gif)

## Getting started

[Example](https://github.com/esivuedaniel/OverlayLoaderWithAppIcon/blob/master/example/example.dart)

Add package to pubspec.yaml

```
dependencies:
  ...
  overlay_loader_with_app_icon:
```
Next, import the library into your widget.

```dart
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
```

## Usage

To make an async call and display a modal with an appIcon progress indicator while the async call is taking place, wrap [OverlayLoaderWithAppIcon] around any widget.
Using the [isLoading] boolean variable, the progress loader can be enabled or disabled.

```dart

bool _loading = false;
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: OverlayLoaderWithAppIcon(
        isLoading: _loading,
        appIcon:  Image.asset('images/appIcon.png'),
        child: Container(
       child: Form(...)
    )),
  );
}
```
## More Options
The current parameters are customizable in the constructor
```dart
OverlayLoaderWithAppIcon({
  required this.isLoading, 
  required this.child, 
  required this.appIcon, 
  this.appIconSize=50,
  this.borderRadius=15, 
  this.overlayOpacity=0.5, 
  this.circularProgressColor, 
  this.overlayBackgroundColor
});
```



## Thank you for using my package😊🙏🏻

## If you need more features
Please open an issue so that we can discuss it

