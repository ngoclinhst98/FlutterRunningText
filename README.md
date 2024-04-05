Flutter widget "running text". Allows running an array string. Allows running an array string.
Provides customizations including two horizontal directions, velocity, fading when appearing or
disappearing.

## Features

[feature.webm](https://github.com/ngoclinhst98/FlutterRunningText/assets/65496918/807086c5-8ffe-4660-85e2-515a7bcba7e1)

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
