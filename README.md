Flutter widget "running text". Allows running an array string. Allows running an array string.
Provides customizations including two horizontal directions, velocity, fading when appearing or
disappearing.

## Features

[feature.mp4](..%2F..%2F..%2F..%2FDownloads%2Ffeature.mp4)

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