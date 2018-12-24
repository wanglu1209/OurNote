import 'package:flutter/material.dart';
import 'dart:math';
import 'package:our_note/utils/CalcGradientColor.dart';

class GradientInstrumentPanel extends StatefulWidget {
  @override
  _GradientInstrumentPanelState createState() =>
      _GradientInstrumentPanelState();
}

class _GradientInstrumentPanelState extends State<GradientInstrumentPanel> {
  _GradientInstrumentPanelPainter painter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    painter = _GradientInstrumentPanelPainter();
    // Future.delayed(Duration(seconds: 2)).then((e) {
    //   for (int i = 0; i < 30; i++) {
    //     painter.setProgress(i);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('GradientInstrumentPanel')),
        body: Container(
          child: Center(
            child: CustomPaint(
              painter: painter,
              size: Size(150, 150),
            ),
          ),
        ));
  }
}

class _GradientInstrumentPanelPainter extends CustomPainter {
  int currentProgress = 30;
  int oldProgress = 0;
  setProgress(int progress) {
    oldProgress = currentProgress;
    currentProgress = progress;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final startColor = Color(0xFF4B53FF);
    final stopColor = Color(0xFFFD3353);
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final grayProgressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
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
        canvas.drawLine(Offset(size.width - size.width * 0.2, 0),
            Offset(size.width, 0), progressPaint);
      } else {
        // 大于当前进度的用灰色来画
        canvas.drawLine(Offset(size.width - size.width * 0.2, 0),
            Offset(size.width, 0), grayProgressPaint);
      }
      // 等于当前进度的变长
      if (i == currentProgress) {
        canvas.drawLine(Offset(size.width - size.width * 0.2, 0),
            Offset(size.width + size.width * 0.1, 0), progressPaint);
      }
      canvas.rotate(rotateAngle);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) =>
      oldProgress != currentProgress;
}
