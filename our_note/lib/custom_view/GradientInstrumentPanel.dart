import 'package:flutter/material.dart';
import 'dart:math';
import 'package:our_note/utils/CalcGradientColor.dart';
import 'dart:ui' as ui;
import 'dart:ui';

num degToRad(num deg) => deg * (pi / 180.0);
num radToDeg(num rad) => rad * (180.0 / pi);

class GradientInstrumentPanel extends StatefulWidget {
  final double width, height;
  double progress;
  final Duration duration;
  bool isEnable;

  GradientInstrumentPanel(
      {this.width = 300.0,
      this.height = 300.0,
      this.isEnable = false,
      @required this.progress,
      this.duration = const Duration(milliseconds: 1000)});

  @override
  _GradientInstrumentPanelState createState() =>
      _GradientInstrumentPanelState();
}

class _GradientInstrumentPanelState extends State<GradientInstrumentPanel>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);

    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPanUpdate(Offset position, BuildContext context) {
    RenderBox box = context.findRenderObject();
    Offset local = box.globalToLocal(position);
    final double x = local.dx;
    final double y = local.dy;
    final double center = widget.width / 2;
    if (checkValidTouch(local)) {
      double radians = atan((x - center) / (center - y));
      if (y > center) {
        radians += degToRad(180);
      } else if (x < center) {
        radians += degToRad(360);
      }
      double progress = (radians / degToRad(360) + 0.5) % 1 * 51;
      if (progress > 50) {
        progress = 50;
      }
      widget.progress = progress;
      setState(() {});
    }
  }

  // 判断点击的位置是否在圆环上
  bool checkValidTouch(Offset point) {
    final double innerRadius = 0;
    final double dx = point.dx;
    final double dy = point.dy;
    final double distanceToCenter =
        sqrt(pow(dx - widget.width / 2, 2) + pow(dy - widget.height / 2, 2));
    if (distanceToCenter < innerRadius || distanceToCenter > widget.width / 2)
      return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey key = GlobalKey();
    return GestureDetector(
        onPanStart: (d) {
          if (widget.isEnable)
            _onPanUpdate(d.globalPosition, key.currentContext);
        },
        onPanUpdate: (details) {
          if (widget.isEnable)
            _onPanUpdate(details.globalPosition, key.currentContext);
        },
        child: CustomPaint(
          key: key,
          painter: _GradientInstrumentPanelPainter(
              (_animationController.value * widget.progress).toInt()),
          size: Size(widget.width, widget.height),
        ));
  }
}

class _GradientInstrumentPanelPainter extends CustomPainter {
  int currentProgress = -1;

  _GradientInstrumentPanelPainter(int progress) {
    currentProgress = progress;
  }
  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
    //     Paint()..color = Colors.blue);

    final startColor = Color(0xFF4B53FF);
    final stopColor = Color(0xFFFD3353);
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final grayProgressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = Colors.grey[300];

    final grayInnerProgressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.grey[300];

    canvas.save();
    // 画仪表盘重要的一点思路就是旋转画布，但是因为flutter中旋转画布只能从坐标原点旋转
    // 所以，先位移画布一半的距离，然后在X轴上画一条线，然后开始旋转角度，划线就ok了
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(pi * 0.75);
    double rotateAngle = (pi + pi / 2.0) / 50.0;
    for (int i = 0; i < 51; i++) {
      progressPaint.color =
          CalcGradientColor.calc(i, currentProgress, startColor, stopColor);
      // 判断小于等于当前进度的用渐变色来画
      if (i <= currentProgress) {
        canvas.drawLine(Offset(size.width / 2 - size.width / 2 * 0.3, 0),
            Offset(size.width / 2 - size.width / 2 * 0.1, 0), progressPaint);
      } else {
        // 大于当前进度的用灰色来画
        canvas.drawLine(
            Offset(size.width / 2 - size.width / 2 * 0.3, 0),
            Offset(size.width / 2 - size.width / 2 * 0.1, 0),
            grayProgressPaint);
      }
      // 等于当前进度的变长
      if (i == currentProgress) {
        canvas.drawLine(Offset(size.width / 2 - size.width / 2 * 0.3, 0),
            Offset(size.width / 2, 0), progressPaint);
      }

      ParagraphConstraints pc = ParagraphConstraints(width: 20);
      ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
        fontSize: 10,
      ));
      pb.pushStyle(ui.TextStyle(color: Colors.grey));

      // 画内部小线
      if (i % 10 == 0) {
        pb.addText((i * 2).toString());
        canvas.drawParagraph(pb.build()..layout(pc),
            Offset(size.width / 2 - size.width / 2 * 0.55, -5));

        canvas.drawLine(
            Offset(size.width / 2 - size.width / 2 * 0.42, 0),
            Offset(size.width / 2 - size.width / 2 * 0.35, 0),
            grayInnerProgressPaint);
      } else
        canvas.drawLine(
            Offset(size.width / 2 - size.width / 2 * 0.38, 0),
            Offset(size.width / 2 - size.width / 2 * 0.35, 0),
            grayInnerProgressPaint);
      canvas.rotate(rotateAngle);
    }
    canvas.restore();

    ParagraphConstraints pc = ParagraphConstraints(width: 70);
    ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: 30,
    ));

    pb.pushStyle(ui.TextStyle(color: Colors.black));
    pb.addText('${currentProgress * 2}%');
    Paragraph _paragraph = pb.build()..layout(pc);
    canvas.drawParagraph(
        _paragraph,
        Offset(size.width / 2 - _paragraph.width / 2,
            size.height / 2 - _paragraph.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
