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
| <img src="https://raw.githubusercontent.com/flyingV805/Flutter-LiveBackgroundView/refs/heads/main/readme/glares.gif" width="180" /> | <img src="https://raw.githubusercontent.com/flyingV805/Flutter-LiveBackgroundView/refs/heads/main/readme/movingGlares.gif" width="180" /> | <img src="https://raw.githubusercontent.com/flyingV805/Flutter-LiveBackgroundView/refs/heads/main/readme/circles.gif" width="180" /> | <img src="https://raw.githubusercontent.com/flyingV805/Flutter-LiveBackgroundView/refs/heads/main/readme/squares.gif" width="180" /> |


## Usage

Add package to dependencies

```yaml
dependencies:
    animated_background_view: ^0.0.1
```

Add AnimatedBackground View in your widget tree

```dart
const AnimatedBackground(
  fps: 60,
  type: BackgroundType.movingGlares,
  blur: true,
)
```

## Additional information

All rendering is implemented on Canvas for optimal performance. Painter initialization occurs in initState to avoid unnecessary recompositions. The rendering FPS can be adjusted as needed (implemented using Timer.periodic()).

Feel free to suggest your feature requests in the Issues
