# LiveBackgroundView

A Flutter library for creating live animated backgrounds with effects of moving glares, light spots, and dynamic geometric patterns, adding depth and style to your application. Perfect for splash screens, widget decoration, or interface personalization.

## Features

Currently, 4 modes are available:
+ Glares
+ Moving Glares
+ Circles
+ Squares.

Each mode can have a blur effect applied, and shadows can be added to Circles and Squares.

| Glares                                       | MovingGlares                                       | Circles                                       | Squares                                       |
|----------------------------------------------|----------------------------------------------------|-----------------------------------------------|-----------------------------------------------|
| <img src="/readme/glares.gif" width="180" /> | <img src="/readme/movingGlares.gif" width="180" /> | <img src="/readme/circles.gif" width="180" /> | <img src="/readme/squares.gif" width="180" /> |



## Usage

```dart
const AnimatedBackground(
  fps: 60,
  type: BackgroundType.movingGlares,
  blur: true,
)
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
