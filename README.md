Flutter widget "running text". Allows running an string list. Provides customizations including two
horizontal directions, velocity, fading when appearing or disappearing.

## Features

![feature](https://github.com/ngoclinhst98/FlutterRunningText/assets/65496918/1def81b3-e0fd-4574-9de2-4f6cdcf3c61b)

## Usage

This is a minimalistic example:

```dart
RunningTextView
(
data: RunningTextModel([
"Learn how to find target keywords",
"Learn how to find target keywords for any page with our keyword research guide."
]
)
)
```

Full options:

```dart
RunningTextView
(
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

## Note

If you use Running Text in AppBar as Title, you need to adjust titleTextStyle to match the textStyle
data of Running Text