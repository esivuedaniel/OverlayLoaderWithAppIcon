#  Overlay loader with app icon

A clean and light-weight package that shows a beautiful overlay loader with appIcon when initiating an async call.

## Demo App
<table>
<tbody>
  <tr>
    <td align="center">
      <img src="/images/app_img.gif" width="320" height="660"/>
    </td>
    <td align="center">
      <img src="/images/giphy.gif" width="320" height="660"/>
    </td>
  </tr>
</tbody>
</table>

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



## Feel free to contribute to this package!! 🙇‍♂️
If anyone wants to improve this package, you're free to do so

## If you need any features
Please open an issue so that we can discuss your feature request

