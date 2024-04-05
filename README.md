Flutter widget "running text". Allows running an array string. Allows running an array string.
Provides customizations including two horizontal directions, velocity, fading when appearing or
disappearing.

## Features

https://github.com/ngoclinhst98/FlutterRunningText/assets/65496918/3ec0fa35-06ff-46fc-8d73-b2b089cb5c40

## Usage

This is a minimalistic example:
```dart
RunningTextView(
  data: RunningTextModel([
    "Learn how to find target keywords",
    "Learn how to find target keywords for any page with our keyword research guide."
  ])
)
```
Full options:
```dart
RunningTextView(
  data: RunningTextModel(
          ["Learn how to find target keywords",
          "Learn how to find target keywords for any page with our keyword research guide."],
          textStyle: const TextStyle(fontSize: 15),
          velocity: 50,
          direction: RunningTextDirection.leftToRight,
          fadeSide: RunningTextFadeSide.both
  )
)
```
