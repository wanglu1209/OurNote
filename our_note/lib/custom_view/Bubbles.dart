import 'dart:math';

import 'package:flutter/material.dart';

class Bubbles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BubblesState();
  }
}

class _BubblesState extends State<Bubbles> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Bubble> bubbles;
  final int numberOfBubbles = 50;
  final Color color = Color(0xFFFB3353);
  final double maxBubbleSize = 10.0;

  @override
  void initState() {
    super.initState();

    bubbles = List();
    int i = numberOfBubbles;
    while (i > 0) {
      bubbles.add(Bubble(color, maxBubbleSize));
      i--;
    }

    _controller = new AnimationController(
        duration: const Duration(hours: 1000), vsync: this);
    _controller.addListener(() {
      updateBubblePosition();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 按住减速
      onTapDown: (e) {
        slowerSpeed();
      },
      onTapUp: (e) => restoreSpeed(),
      onTapCancel: () => restoreSpeed(),
      child: CustomPaint(
        painter: BubblePainter(bubbles: bubbles, controller: _controller),
        size: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
      ),
    );
  }

  void slowerSpeed() {
    bubbles.forEach((it) => it.setNewSpeed(0.5));
    setState(() {});
  }

  void restoreSpeed() {
    bubbles.forEach((it) => it.setNewSpeed(1));
    setState(() {});
  }

  void updateBubblePosition() {
    bubbles.forEach((it) => it.updatePosition());
    setState(() {});
  }
}

class BubblePainter extends CustomPainter {
  List<Bubble> bubbles;
  AnimationController controller;

  BubblePainter({this.bubbles, this.controller});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    bubbles.forEach((it) => it.draw(canvas, canvasSize));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Bubble {
  Color colour;
  double direction;
  double speed;
  double radius;
  double x;
  double y;

  Bubble(Color colour, double maxBubbleSize) {
    this.colour = colour.withOpacity(Random().nextDouble());
    this.direction = Random().nextDouble() * 360;
    this.speed = 1;
    this.radius = Random().nextDouble() * maxBubbleSize;
  }

  draw(Canvas canvas, Size canvasSize) {
    Paint paint = new Paint()
      ..color = colour
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    assignRandomPositionIfUninitialized(canvasSize);

    randomlyChangeDirectionIfEdgeReached(canvasSize);

    if (x > canvasSize.width) {
      x = canvasSize.width - radius * 2;
      direction /= 2;
    } else if (x < 0) {
      x = radius * 2;
      direction /= 2;
    }
    if (y > canvasSize.height) {
      y = canvasSize.height - radius * 2;
      direction /= 2;
    } else if (y < 0) {
      y = radius * 2;
      direction /= 2;
    }
    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  void assignRandomPositionIfUninitialized(Size canvasSize) {
    if (x == null) {
      this.x = Random().nextDouble() * canvasSize.width;
    }

    if (y == null) {
      this.y = Random().nextDouble() * canvasSize.height;
    }
  }

  setNewSpeed(double newSpeed) {
    speed = newSpeed;
  }

  updatePosition() {
    var a = 180 - (direction + 90);
    try {
      direction > 0 && direction < 180
          ? x += speed * sin(direction) / sin(speed)
          : x -= speed * sin(direction) / sin(speed);
      direction > 90 && direction < 360
          ? y += speed * sin(a) / sin(speed)
          : y -= speed * sin(a) / sin(speed);
    } catch (e) {}
  }

  randomlyChangeDirectionIfEdgeReached(Size canvasSize) {
    if (x > canvasSize.width - radius ||
        x < radius ||
        y > canvasSize.height - radius ||
        y < radius) {
      direction = Random().nextDouble() * 360;
    }
  }
}
